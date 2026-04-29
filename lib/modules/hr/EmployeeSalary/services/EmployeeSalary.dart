import 'package:hrx/core/constant/staticNumbers.dart';
import 'package:hrx/core/function/SalaryFunctions/CalcSalaryClass.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/data/models/LieuesModel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';

class SalaryCalculatorService {
  static const double totalMonthHours = 182;

  SalaryResultModel calculateSalary({
    required int employeeId,
    required String employeeName,
    required double years_number_employement,
    required DateTime AppointmentDate,
    required String qualification,
    required Map<String, double> basicSalary,
    required List<EmployeeDayModel> attendance,
    required int? hrScore,
    required double advance,
    required double penaltiesCount,
    required double rivals,
    required double bonuses,
    required Map<String, int>? cases,
    required List<LieuesModel> lieues,
    required DateTime nextRaiseDate,
    required int year,
    required int month,
    required bool isPaid,
  }) {
    String employeeType = attendance.first.employeeType;
    bool isHalfTime = employeeType == 'half_time';
    Calcsalaryclass().hourMonth = employeeType == 'marketing'
        ? totalMonthHoursMarketing
        : totalMonthHours;

    if (employeeType == 'shifts') {
      return calculateShiftSalary(
        employeeId: employeeId,
        employeeName: employeeName,
        attendance: attendance,
        hrScore: hrScore,
        bonuses: bonuses,
        penaltiesCount: penaltiesCount,
        rivals: rivals,
        lieues: lieues,
        cases: cases,
        year: year,
        month: month,
        isPaid: isPaid,
        AppointmentDate: AppointmentDate,
        years_number_employement: years_number_employement.toInt(),
        qualification: qualification,
        nextRaiseDate: nextRaiseDate,
        advance: advance,
      );
    }

    Map<String, double> workedHours = Calcsalaryclass().calculateWorkedHours(
      attendance,
      AppointmentDate,
    );

    /// نحسب الغياب
    int absenceDays = Calcsalaryclass().calculateAbsence(attendance);
    int attendDays = Calcsalaryclass().calculateAttendsday(attendance);

    /// نحسب التأخير
    final lateDetails = Calcsalaryclass().calculateLate(attendance);

    /// الالتزام الإداري
    double adminCommitment = Calcsalaryclass().calculateAdminCommitment(
      basicSalary['total']!,
      absenceDays,
      lateDetails['total']!,
      penaltiesCount,
      isHalfTime,
    );
    // نسيان البصمة
    double fourgetMoney = Calcsalaryclass().calculateForgetMoney(
      basicSalary['total']!,
      workedHours['forget'] ?? 0,
    );

    /// تقييم HR
    Map<String, double>? hrEvaluation = Calcsalaryclass().calculateHrEvaluation(
      basicSalary['total']!,
      hrScore,
      isHalfTime,
    );
    double penalties = Calcsalaryclass().calculatePenalties(
      penaltiesCount,
      basicSalary['total']!,
      employeeType == 'marketing',
    );

    /// الحضور
    double attendanceAmount = Calcsalaryclass().calculateAttendanceSalary(
      basicSalary['total']!,
      workedHours['net']!,
    );

    /// حساب إجمالي الـ Lieues
    double totalLieues = lieues.fold(0, (sum, item) => sum + item.amount);

    double total = hrEvaluation == null
        ? adminCommitment +
              attendanceAmount +
              bonuses +
              totalLieues -
              penalties -
              rivals -
              fourgetMoney -
              advance
        : adminCommitment +
              hrEvaluation['amount']! +
              attendanceAmount +
              bonuses +
              totalLieues -
              penalties -
              fourgetMoney -
              advance -
              rivals;

    final salaryDetails = SalaryDetails(
      rival: rivals,
      lieues: lieues
          .map((e) => Lieue(name: e.name, amount: e.amount.toDouble()))
          .toList(),
      bonuses: bonuses,
      lateCount: LateCount(
        total: lateDetails['total'] ?? 0,
        quarter: lateDetails['quarter'] ?? 0,
        fullDay: lateDetails['full_day'] ?? 0,
        halfDay: lateDetails['half_day'] ?? 0,
      ),
      absenceDays: absenceDays,
      attendsDays: attendDays,
      basicSalary: BasicSalary(
        total: basicSalary['total'] ?? 0,
        raises: basicSalary['raises'] ?? 0,
        salary: basicSalary['salary'] ?? 0,
        jobGrade: basicSalary['job_grade'] ?? 0,
        otherSalary: basicSalary['other_salary'] ?? 0,
        experienceSalary: basicSalary['experience_salary'] ?? 0,
      ),
      workedHours: WorkedHours(
        total: (workedHours['total'] ?? 0).toDouble(),
        absent: (workedHours['absent'] ?? 0).toDouble(),
        deducted: (workedHours['deducted'] ?? 0).toDouble(),
        fridayAndHoliday: (workedHours['fridayAndHoliday'] ?? 0).toDouble(),
        net: (workedHours['net'] ?? 0).toDouble(),
        real: (workedHours['real'] ?? 0).toDouble(),
        leave: (workedHours['leave'] ?? 0).toDouble(),
        forget: (workedHours['forget'] ?? 0).toDouble(),
        overtime: (workedHours['overtime'] ?? 0).toDouble(),
        friday2: (workedHours['friday2'] ?? 0).toDouble(),
        permission: (workedHours['permission'] ?? 0).toDouble(),
      ),
      nextRaiseDate: nextRaiseDate,
      penaltiesCount: penaltiesCount.toInt(),
      penaltiesAmount: penalties,
      attendanceAmount: attendanceAmount,
      hrEvaluationAmount: HREvaluationAmount(
        score: hrScore ?? 0,
        amount: (hrEvaluation?['amount'] ?? 0),
      ),
      adminCommitmentAmount: adminCommitment,
      advance: advance,
    );

    return SalaryResultModel(
      id: 0,
      employeeId: employeeId,
      name: employeeName,
      salarytype: employeeType,
      year: year,
      month: month,
      salaryDetails: salaryDetails,
      finalSalary: total,
      isPaid: isPaid,
      paidAt: DateTime.now(),
      yearsNumberEmployement: years_number_employement.toInt(),
      qualification: qualification,
      appointmentDate: AppointmentDate,
      ishalf: isHalfTime,
    );
  }

  SalaryResultModel recalcSalaryAfterAbsence(
    SalaryResultModel salary,
    int newAbsence,
  ) {
    final details = salary.salaryDetails as SalaryDetails;
    final int oldAbsence = details.absenceDays; // 1
    final daysAbsence = newAbsence + oldAbsence; // 2
    final oldHoursAbsence = details.workedHours.absent; // 7

    double adminCommitment = Calcsalaryclass().calculateAdminCommitment(
      details.basicSalary.total,
      daysAbsence,
      details.lateCount.total,
      details.penaltiesCount.toDouble(),
      salary.salarytype == 'half_time',
    );
    double hoursAbsent = (newAbsence * shiftHours * 4) + oldHoursAbsence;

    details.workedHours.absent = hoursAbsent;
    double houRate = details.basicSalary.total / totalMonthHours;
    double detectedAbseentMoney = houRate * hoursAbsent;

    /// تحديث SalaryDetails
    final newDetails = SalaryDetails(
      rival: details.rival,
      lieues: details.lieues,
      bonuses: details.bonuses,
      lateCount: details.lateCount,
      absenceDays: daysAbsence,
      attendsDays: details.attendsDays,
      basicSalary: details.basicSalary,
      workedHours: details.workedHours,
      nextRaiseDate: details.nextRaiseDate,
      penaltiesCount: details.penaltiesCount,
      penaltiesAmount: details.penaltiesAmount,
      attendanceAmount: details.attendanceAmount,
      hrEvaluationAmount: details.hrEvaluationAmount,
      adminCommitmentAmount: adminCommitment,
      advance: details.advance,
    );

    /// إعادة حساب الراتب النهائي
    double finalSalary =
        details.bonuses +
        details.attendanceAmount +
        details.hrEvaluationAmount.amount +
        adminCommitment -
        details.penaltiesAmount -
        details.rival -
        details.advance -
        detectedAbseentMoney;

    return SalaryResultModel(
      id: salary.id,
      employeeId: salary.employeeId,
      name: salary.name,
      year: salary.year,
      month: salary.month,
      salaryDetails: newDetails,
      finalSalary: finalSalary,
      isPaid: salary.isPaid,
      paidAt: salary.paidAt,
      yearsNumberEmployement: salary.yearsNumberEmployement,
      qualification: salary.qualification,
      appointmentDate: salary.appointmentDate,
      ishalf: true,
    );
  }

  SalaryResultModel calculateShiftSalary({
    required int employeeId,
    required String employeeName,
    required List<EmployeeDayModel> attendance,
    required int? hrScore,
    required double bonuses,
    required double advance,
    required double penaltiesCount,
    required DateTime AppointmentDate,
    required int years_number_employement,
    required double rivals,
    required List<LieuesModel> lieues,
    required String qualification,
    required DateTime nextRaiseDate,
    required Map<String, int>? cases,
    required int year,
    required int month,
    required bool isPaid,
  }) {
    int shiftsCount = attendance
        .where((d) => d.checkIn != null && d.checkOut != null)
        .length;

    double shiftPrice = attendance.first.shiftPrice ?? 0;

    double shiftsSalary = shiftsCount * shiftPrice;
    Map<String, double>? hrEvaluation = Calcsalaryclass().calculateHrEvaluation(
      shiftsSalary,
      hrScore,
    );

    /// lieues
    double totalLieues = lieues.fold(0, (sum, item) => sum + item.amount);
    double penaltiesAmount = shiftPrice * penaltiesCount;
    final hrShiftTotalScore = shiftsSalary * HrEvaluationPercent;
    final detectedhrShiftScore =
        hrShiftTotalScore - (hrEvaluation?['amount'] ?? 0);
    final int casesGeneral = cases!['cases'] ?? 0;
    final int casesDye = cases['dye_cases'] ?? 0;

    final double casesGeneralMoney = casesGeneral * 10;
    final double casesDyeMoney = casesDye * 50;

    double finalSalary =
        shiftsSalary +
        bonuses +
        casesGeneralMoney +
        casesDyeMoney +
        totalLieues -
        penaltiesAmount -
        rivals -
        advance -
        detectedhrShiftScore;

    final salarydetails = ShiftSalaryDetails(
      shiftsCount: shiftsCount,
      shiftPrice: shiftPrice,
      cases: casesGeneral,
      dyeCases: casesDye,
      casesAmount: casesGeneralMoney,
      dyeAmount: casesDyeMoney,
      hrEvaluation: hrEvaluation != null
          ? HREvaluationAmount(
              amount: hrEvaluation['amount'] ?? 0,
              score: hrScore ?? 0,
            )
          : HREvaluationAmount(amount: 0, score: 0),
      bonuses: bonuses,
      penalties: penaltiesAmount,
      rivals: rivals,
      penaltiesCount: penaltiesCount,
      detectedhrShiftAmount: detectedhrShiftScore,
      advance: advance,
    );

    return SalaryResultModel(
      id: 0,
      employeeId: employeeId,
      name: employeeName,
      salarytype: 'shifts',
      year: year,
      month: month,
      finalSalary: finalSalary,
      isPaid: isPaid,
      paidAt: DateTime.now(),
      salaryDetails: salarydetails,
      yearsNumberEmployement: years_number_employement,
      qualification: qualification,
      appointmentDate: AppointmentDate,
    );
  }
}
