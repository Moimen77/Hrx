// ignore_for_file: constant_identifier_names

import 'package:hrx/core/constant/staticNumbers.dart';
import 'package:hrx/core/function/SalaryFunctions/DeductHoursLate.dart';
import 'package:hrx/core/issixMonthsAfterAppointment.dart';
import 'package:hrx/data/models/employeeDayModel.dart';

class Calcsalaryclass {
  double hourMonth = totalMonthHours;
  bool isnoLeave(EmployeeDayModel e) =>
      (e.status == "leave" &&
      e.hr_leave_approve == "مرفوضة" &&
      e.checkIn == null);

  int calculateAttendsday(List<EmployeeDayModel> attendance) {
    return attendance
        .where((e) => e.checkIn != null && e.checkOut != null)
        .length;
  }

  Map<String, double> calculateWorkedHours(
    List<EmployeeDayModel> attendance,
    DateTime appointmentDate,
  ) {
    Map<String, double> workedHoursDetails = {
      "total": 0,
      "net": 0,
      'real': 0,
      'leave': 0,
      'overtime': 0,
      'absent': 0,
      'forget': 0,
      'deducted': 0,
      'friday2': 0,
      'permission': 0,
      'fridayAndHoliday': 0,
    };
    final bool sixMonthsAfterAppointment = issixMonthsAfterAppointment(
      appointmentDate,
    );

    for (var day in attendance) {
      final isFriday = day.status == 'friday';
      final isThursday = day.date.weekday == DateTime.thursday;
      final isMarketing = day.employeeType == 'marketing';
      final isofficalHoliday = day.status == 'official_holiday';

      final isMarketingWeekend = isMarketing && (isThursday || isFriday);

      if (day.employeeType != 'half_time') {
        if (day.status == 'absent' && !isMarketingWeekend) {
          workedHoursDetails['absent'] =
              (workedHoursDetails['absent'] ?? 0) + shiftHours * 4;
        }
      }

      if (day.leaveType != null && day.status == 'leave') {
        if (day.hr_leave_approve != 'مقبولة' && day.checkIn == null) {
          workedHoursDetails['absent'] =
              (workedHoursDetails['absent'] ?? 0) +
              shiftHours * (day.hrDecisionDay ?? 0);
        } else {
          // موافقة
          if (sixMonthsAfterAppointment && day.checkIn == null) {
            workedHoursDetails['leave'] =
                (workedHoursDetails['leave'] ?? 0) +
                (isMarketing ? shiftHoursMarketing : shiftHours);
          }
        }
      }

      if (day.checkIn != null && day.checkOut == null) {
        workedHoursDetails['forget'] =
            (workedHoursDetails['forget'] ?? 0) +
            (isMarketing
                ? (shiftHoursMarketing / 2)
                : (shiftHours / 2)); // يمكت تتعدل الماركتنج
      }

      // أيام فيها حضور
      if (day.checkIn != null && day.checkOut != null) {
        double hours = day.checkOut!.difference(day.checkIn!).inMinutes / 60;
        if (day.permission_minute > 0) {
          workedHoursDetails['permission'] =
              (workedHoursDetails['permission'] ?? 0) + permission_hours;
        }
        double overtimeHours = 0;
        if (day.overtime > 0 && day.overtime < 360) {
          overtimeHours = (day.overtime / 60) * 2;
        }
        if (day.overtime > 300) {
          overtimeHours = (day.overtime / 60);
        }
        workedHoursDetails['overtime'] =
            (workedHoursDetails['overtime'] ?? 0) + overtimeHours;
        // جمعة بحضور → ×2
        if (isFriday) {
          hours *= 2;
          workedHoursDetails['friday2'] =
              (workedHoursDetails['friday2'] ?? 0) + hours;
        }
        if (isofficalHoliday) {
          workedHoursDetails['fridayAndHoliday'] =
              (workedHoursDetails['fridayAndHoliday'] ?? 0) + hours;
        }
        workedHoursDetails['real'] = (workedHoursDetails['real'] ?? 0) + hours;
      }
      workedHoursDetails['deducted'] =
          (workedHoursDetails['deducted'] ?? 0) +
          latePenaltyToHours(day.late_penalty_type);
    }
    workedHoursDetails['total'] =
        (workedHoursDetails['real'] ?? 0) +
        (workedHoursDetails['friday2'] ?? 0) +
        (workedHoursDetails['overtime'] ?? 0) +
        (workedHoursDetails['fridayAndHoliday'] ?? 0) +
        (workedHoursDetails['friday'] ?? 0) +
        (workedHoursDetails['permission'] ?? 0) +
        (workedHoursDetails['leave'] ?? 0);
    workedHoursDetails['net'] =
        workedHoursDetails['total']! -
        (workedHoursDetails['deducted'] ?? 0) -
        (workedHoursDetails['absent'] ?? 0);

    return workedHoursDetails;
  }

  int calculateAbsence(List<EmployeeDayModel> attendance) {
    if (attendance.isEmpty) {
      return 0;
    }
    final employeeType = attendance.first.employeeType;
    int absences = 0;
    if (employeeType != "half_time") {
      absences = attendance
          .where(
            (e) =>
                (e.status == "absent") ||
                isnoLeave(e) /* يكون غايب او اجازة مرفوضة و مجاش*/,
          )
          .length;
      return absences;
    } else {
      absences = attendance.where((e) => isnoLeave(e)).length;
    }
    return absences;
  }

  Map<String, int> calculateLate(List<EmployeeDayModel> attendance) {
    Map<String, int> details = {
      'quarter': 0,
      'half_day': 0,
      'full_day': 0,
      'other': 0,
      'total': 0,
    };

    for (var element in attendance) {
      if (element.late_penalty_type != null &&
          element.late_penalty_type!.isNotEmpty) {
        details['total'] = details['total']! + 1;
        if (details.containsKey(element.late_penalty_type)) {
          details[element.late_penalty_type!] =
              details[element.late_penalty_type]! + 1;
        } else {
          details['other'] = details['other']! + 1;
        }
      }
    }
    return details;
  }

  double calculateAdminCommitment(
    double basicSalary,
    int absenceDays,
    int lateCount,
    double penaltiesCount, [
    bool ishalf = false,
  ]) {
    double part = (basicSalary * AdminCommitmentPercent) / 3;

    double result = basicSalary * AdminCommitmentPercent;
    if (absenceDays > 0) result -= part;
    if (lateCount >= 4) result -= part;
    if (penaltiesCount > 0) result -= part;

    return ishalf ? (result / 2) : result;
  }

  double calculatePenalties(
    double penaltiesAmountDays,
    double basicSalary, [
    bool isMarketing = false,
  ]) {
    final hour_rate = basicSalary / hourMonth;
    return penaltiesAmountDays *
        hour_rate *
        (isMarketing ? shiftHoursMarketing : shiftHours);

    /// Here Not 7
  }

  Map<String, double>? calculateHrEvaluation(
    double basicSalary,
    int? score, [
    bool ishalf = false,
  ]) {
    double percent;
    if (score == null) {
      return null;
    }

    if (score >= 90) {
      percent = 1;
    } else if (score >= 75) {
      percent = 0.75;
    } else if (score >= 50) {
      percent = 0.5;
    } else {
      percent = 0;
    }
    final amount = basicSalary * HrEvaluationPercent * percent;
    return {'amount': ishalf ? amount / 2 : amount, 'score': score.toDouble()};
  }

  double calculateAttendanceSalary(double basicSalary, double workedHours) {
    double hourRate = (basicSalary) / hourMonth;
    return workedHours * hourRate;
  }

  double calculateForgetMoney(double basicSalary, double forgetHours) {
    double hourRate = (basicSalary) / hourMonth;
    return forgetHours * hourRate;
  }
}
