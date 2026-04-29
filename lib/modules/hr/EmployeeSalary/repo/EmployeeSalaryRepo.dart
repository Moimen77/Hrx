import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/data/models/LieuesModel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/hr/EmployeeSalary/services/EmployeeSalary.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalaryRepo {
  final SupabaseClient supabase;

  SalaryRepo(this.supabase);

  // ===============================
  // Main Function
  // ===============================
  Future<SalaryResultModel> calculateEmployeeSalary({
    required int employeeId,
    String employeeName = "",
    double years_number_employement = 0,
    String qualification = '',
    required int year,
    required int month,
    required int? hrScore,
    required DateTime AppointmentDate,
    required bool isPaid,
    required String employeeType,
  }) async {
    final basicSalary = await _getBasicSalary(employeeId, year, month);

    final attendance = await _getAttendance(employeeId, year, month);

    final penaltiesCount = await _getPenaltiesCount(
      employeeId,
      year,
      month,
      false,
    );
    final total_bonues = await _getTotalbonues(employeeId, year, month);

    final rivals = await _getPenaltiesCount(employeeId, year, month, true);

    final lieues = await _getLieues(employeeId, year, month);
    final advance = await getEmployeeAdvancesSum(
      empId: employeeId,
      year: year,
      month: month,
    );

    final nextRaiseDate = await _getNextRaiseDate(employeeId, AppointmentDate);
    Map<String, int>? cases;

    if (employeeType == 'shifts') {
      cases = await getShiftStats(employeeId, year, month);
    }

    final calculator = SalaryCalculatorService();

    return calculator.calculateSalary(
      employeeId: employeeId,
      employeeName: employeeName,
      basicSalary: basicSalary,
      attendance: attendance,
      hrScore: hrScore,
      penaltiesCount: penaltiesCount,
      years_number_employement: years_number_employement,
      qualification: qualification,
      rivals: rivals,
      advance: advance,
      bonuses: total_bonues,
      lieues: lieues,
      AppointmentDate: AppointmentDate,
      nextRaiseDate: nextRaiseDate,
      year: year,
      month: month,
      isPaid: isPaid,
      cases: cases,
    );
  }

  // ===============================
  // Calculate All Employees
  // ===============================
  Future<List<SalaryResultModel>> calculateAllSalaries({
    required int year,
    required int month,
  }) async {
    final now = DateTime.now();

    if (year == now.year && month == now.month) {
      return _calculateLiveSalaries(year, month);
    }
    if (year == now.year && month == now.month - 1 && now.day <= 15) {
      return _calculateLiveSalaries(year, month);
    }

    final res = await supabase
        .from('salary_view')
        .select()
        .eq('year', year)
        .eq('month', month);
    if (res.isNotEmpty) {
      return res
          .map((e) => SalaryResultModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return [];
  }

  Future<List<SalaryResultModel>> _calculateLiveSalaries(
    int year,
    int month,
  ) async {
    final salariesPaid = await supabase
        .from('employee_salaries')
        .select('employee_id')
        .eq('year', year)
        .eq('month', month);
    final List<int> employeesRecivedSalary = [];
    for (var salary in salariesPaid) {
      employeesRecivedSalary.add(salary['employee_id']);
    }

    final employeesRes = await supabase
        .from('Employees')
        .select(
          'id, name, AppointmentDate, qualification, years_number_employement , employee_type',
        );

    final hrScoresRes = await supabase
        .from('Hr_Evaluation')
        .select('employee_id, HrScore')
        .eq('Year', year)
        .eq('score_month', month);

    final hrScoresMap = {
      for (var score in hrScoresRes)
        score['employee_id']: score['HrScore'] as int?,
    };

    List<Future<SalaryResultModel>> futures = [];

    for (var emp in employeesRes) {
      final int id = emp['id'];
      final String name = emp['name'];
      final int? hrScore = hrScoresMap[id];
      final String qualification = emp['qualification'] ?? '';
      final double years = (emp['years_number_employement'] ?? 0).toDouble();
      final DateTime appointmentDate = DateTime.parse(emp['AppointmentDate']);
      final String employeeType = emp['employee_type'] ?? 'full_time';

      futures.add(
        calculateEmployeeSalary(
          employeeId: id,
          employeeName: name,
          year: year,
          month: month,
          hrScore: hrScore,
          qualification: qualification,
          years_number_employement: years,
          AppointmentDate: appointmentDate,
          isPaid: employeesRecivedSalary.contains(id),
          employeeType: employeeType,
        ),
      );
    }

    return Future.wait(futures);
  }

  Future<Map<String, double>> _getBasicSalary(
    int employeeId,
    int year,
    int month,
  ) async {
    final Map<String, double> SalaryDetailsMap = {
      'salary': 0,
      'job_grade': 0,
      'experience_salary': 0,
      'other_salary': 0,
      'raises': 0,
      'total': 0,
    };

    // 1. جلب مكونات الراتب من جدول الموظفين
    final empRes = await supabase
        .from('Employees')
        .select('salary, job_grade, experience_salary, other_salary')
        .eq('id', employeeId)
        .single();

    SalaryDetailsMap['salary'] = (empRes['salary'] ?? 0).toDouble();
    SalaryDetailsMap['job_grade'] = (empRes['job_grade'] ?? 0).toDouble();
    SalaryDetailsMap['experience_salary'] = (empRes['experience_salary'] ?? 0)
        .toDouble();
    SalaryDetailsMap['other_salary'] = (empRes['other_salary'] ?? 0).toDouble();

    double total =
        (empRes['salary'] ?? 0).toDouble() +
        (empRes['job_grade'] ?? 0).toDouble() +
        (empRes['experience_salary'] ?? 0).toDouble() +
        (empRes['other_salary'] ?? 0).toDouble();

    // 2. جلب الزيادات السنوية (Raises) المستحقة حتى نهاية شهر الراتب
    final nextMonthDate = DateTime(
      year,
      month + 1,
      1,
    ); // أول يوم في الشهر التالي
    final raisesRes = await supabase
        .from('EmployeeRaises')
        .select('raise_amount')
        .eq('employee_id', employeeId)
        .lt('effective_date', nextMonthDate.toIso8601String());

    double totalRaises = 0;
    for (var raise in raisesRes) {
      totalRaises += (raise['raise_amount'] ?? 0).toDouble();
    }
    SalaryDetailsMap['raises'] = totalRaises;
    SalaryDetailsMap['total'] = total + totalRaises;

    return SalaryDetailsMap;
  }

  // ===============================
  // Attendance
  // ===============================
  Future<List<EmployeeDayModel>> _getAttendance(
    int employeeId,
    int year,
    int month,
  ) async {
    final startDate = DateTime(year, month - 1, 26);
    DateTime endDate = DateTime(year, month, 26);

    final now = DateTime.now();
    if (year == now.year && month == now.month) {
      endDate = DateTime(now.year, now.month, now.day.clamp(1, 26));
    }

    final res = await supabase.rpc(
      'employee_attendance_table',
      params: {
        'p_employee_id': employeeId,
        'p_start_date': startDate.toIso8601String(),
        'p_end_date': endDate.toIso8601String(),
      },
    );
    return (res as List).map((e) => EmployeeDayModel.fromJson(e)).toList();
  }

  // ===============================
  // Penalties
  // ===============================
  Future<double> _getPenaltiesCount(
    int employeeId,
    int year,
    int month,
    bool isrival,
  ) async {
    final startDate = DateTime(year, month - 1, 26);
    DateTime endDate = DateTime(year, month, 26);

    final res = await supabase.rpc(
      isrival ? 'get_total_rival' : 'get_total_penalties',
      params: {
        'p_employee_id': employeeId,
        'p_start': startDate.toIso8601String(),
        'p_end': endDate.toIso8601String(),
      },
    );

    final totalPenalty = (res).toDouble();
    return totalPenalty;
  }

  Future<void> paySalary(Map<String, dynamic> data) async {
    await supabase.from('employee_salaries').insert(data);
  }

  Future<double> _getTotalbonues(int employeeId, int year, int month) async {
    final startDate = DateTime(year, month - 1, 26);
    DateTime endDate = DateTime(year, month, 26);

    final res = await supabase.rpc(
      'get_total_bonues',
      params: {
        'p_employee_id': employeeId,
        'p_start': startDate.toIso8601String(),
        'p_end': endDate.toIso8601String(),
      },
    );

    final total_bonues = (res).toDouble();
    return total_bonues;
  }

  Future<double> getEmployeeAdvancesSum({
    required int empId,
    required int year,
    required int month,
  }) async {
    final response = await supabase.rpc(
      'get_employee_approved_advances_sum',
      params: {'emp_id': empId, 'target_year': year, 'target_month': month},
    );

    if (response == null) {
      return 0.0;
    }
    return (response as num).toDouble();
  }

  Future<SalaryResultModel> recalcSalaryAfterAbsence(
    SalaryResultModel salary,
    int newAbsence,
  ) async {
    final calculator = SalaryCalculatorService();
    return calculator.recalcSalaryAfterAbsence(salary, newAbsence);
  }

  Future<List<LieuesModel>> _getLieues(
    int employeeId,
    int year,
    int month,
  ) async {
    final res = await supabase
        .from('lieues')
        .select()
        .eq('employee_id', employeeId)
        .eq('lieue_year', year)
        .eq('lieue_month', month);

    return (res as List).map((e) => LieuesModel.fromJson(e)).toList();
  }

  Future<DateTime> _getNextRaiseDate(
    int employeeId,
    DateTime appointmentDate,
  ) async {
    final res = await supabase
        .from('EmployeeRaises')
        .select('effective_date')
        .eq('employee_id', employeeId)
        .order('effective_date', ascending: false)
        .limit(1)
        .maybeSingle();

    if (res != null) {
      final lastRaise = DateTime.parse(res['effective_date']);
      return DateTime(lastRaise.year + 1, lastRaise.month, lastRaise.day);
    } else {
      return DateTime(
        appointmentDate.year + 1,
        appointmentDate.month,
        appointmentDate.day,
      );
    }
  }

  // ===============================
  // Update HR Score
  // ===============================
  Future<void> updateHrScore({
    required int employeeId,
    required int year,
    required int month,
    required int score,
  }) async {
    final existing = await supabase
        .from('Hr_Evaluation')
        .select('id')
        .eq('employee_id', employeeId)
        .eq('Year', year)
        .eq('score_month', month)
        .maybeSingle();

    if (existing != null) {
      await supabase
          .from('Hr_Evaluation')
          .update({'HrScore': score})
          .eq('id', existing['id']);
    } else {
      await supabase.from('Hr_Evaluation').insert({
        'employee_id': employeeId,
        'Year': year,
        'score_month': month,
        'HrScore': score,
      });
    }
  }

  Future<Map<String, int>> getShiftStats(
    int employeeId,
    int year,
    int month,
  ) async {
    final res = await supabase
        .from('employee_shift_stats')
        .select()
        .eq('employee_id', employeeId)
        .eq('year', year)
        .eq('month', month)
        .maybeSingle();

    if (res == null) {
      return {"cases": 0, "dye_cases": 0};
    }

    return {"cases": res['cases'], "dye_cases": res['dye_cases']};
  }

  Future<void> upsertShiftStats({
    required int employeeId,
    required int year,
    required int month,
    required int cases,
    required int dyeCases,
  }) async {
    final existing = await supabase
        .from('employee_shift_stats')
        .select('id')
        .eq('employee_id', employeeId)
        .eq('year', year)
        .eq('month', month)
        .maybeSingle();

    if (existing != null) {
      await supabase
          .from('employee_shift_stats')
          .update({'cases': cases, 'dye_cases': dyeCases})
          .eq('id', existing['id']);
    } else {
      await supabase.from('employee_shift_stats').insert({
        'employee_id': employeeId,
        'year': year,
        'month': month,
        'cases': cases,
        'dye_cases': dyeCases,
      });
    }
  }

  Future<void> addAllowances(List<Map<String, dynamic>> allowances) async {
    try {
      await supabase.from('lieues').insert(allowances);
    } catch (e) {
      rethrow;
    }
  }
}
