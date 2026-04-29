class SalaryResultModel {
  final int id;
  final int employeeId;
  final String name;
  final int year;
  final int month;
  final String? salarytype;
  final SalaryDetailsBase salaryDetails;
  final double finalSalary;
  final bool isPaid;
  final DateTime paidAt;
  final int yearsNumberEmployement;
  final String qualification;
  final DateTime appointmentDate;
  final bool? ishalf;

  SalaryResultModel({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.year,
    required this.month,
    required this.salaryDetails,
    required this.finalSalary,
    required this.isPaid,
    required this.paidAt,
    required this.yearsNumberEmployement,
    required this.qualification,
    required this.appointmentDate,
    this.ishalf,
    this.salarytype,
  });

  SalaryResultModel copyWith({SalaryDetails? salaryDetails}) {
    return SalaryResultModel(
      id: id,
      employeeId: employeeId,
      name: name,
      year: year,
      month: month,
      salaryDetails: salaryDetails ?? this.salaryDetails,
      finalSalary: finalSalary,
      isPaid: isPaid,
      paidAt: paidAt,
      yearsNumberEmployement: yearsNumberEmployement,
      qualification: qualification,
      appointmentDate: appointmentDate,
      ishalf: ishalf,
      salarytype: salarytype,
    );
  }

  factory SalaryResultModel.fromJson(Map<String, dynamic> json) {
    final type = json['employee_type'];
    final detailsJson = json['salary_details'];

    SalaryDetailsBase details;

    if (type == 'shifts') {
      details = ShiftSalaryDetails.fromJson(detailsJson);
    } else {
      details = SalaryDetails.fromJson(detailsJson);
    }

    return SalaryResultModel(
      id: json['id'],
      employeeId: json['employee_id'],
      name: json['name'],
      year: json['year'],
      month: json['month'],
      salaryDetails: details,
      finalSalary: (json['final_salary'] as num).toDouble(),
      isPaid: json['is_paid'],
      salarytype: json['employee_type'],
      paidAt: DateTime.parse(json['paid_at']),
      yearsNumberEmployement: json['years_number_employement'] ?? 0,
      qualification: json['qualification'],
      appointmentDate: DateTime.parse(json['AppointmentDate']),
    );
  }
  Map<String, dynamic> toJson() => {
    'employee_id': employeeId,
    'year': year,
    'month': month,
    'salary_details': salaryDetails.toJson(),
    'final_salary': finalSalary,
    'is_paid': true,
    'paid_at': paidAt.toIso8601String(),
  };
}

abstract class SalaryDetailsBase {
  Map<String, dynamic> toJson();
}

class SalaryDetails extends SalaryDetailsBase {
  final double rival;
  final double advance;
  final List<Lieue> lieues;
  final double bonuses;
  final LateCount lateCount;
  int absenceDays;
  final int attendsDays;
  final BasicSalary basicSalary;
  final WorkedHours workedHours;
  final DateTime nextRaiseDate;
  final int penaltiesCount;
  final double penaltiesAmount;
  final double attendanceAmount;
  final HREvaluationAmount hrEvaluationAmount;
  final double adminCommitmentAmount;

  SalaryDetails({
    required this.rival,
    required this.advance,
    required this.lieues,
    required this.bonuses,
    required this.lateCount,
    required this.absenceDays,
    required this.attendsDays,
    required this.basicSalary,
    required this.workedHours,
    required this.nextRaiseDate,
    required this.penaltiesCount,
    required this.penaltiesAmount,
    required this.attendanceAmount,
    required this.hrEvaluationAmount,
    required this.adminCommitmentAmount,
  });

  SalaryDetails copyWith({int? absenceDays}) {
    return SalaryDetails(
      rival: rival,
      lieues: lieues,
      bonuses: bonuses,
      lateCount: lateCount,
      absenceDays: absenceDays ?? this.absenceDays,
      attendsDays: attendsDays,
      basicSalary: basicSalary,
      workedHours: workedHours,
      nextRaiseDate: nextRaiseDate,
      penaltiesCount: penaltiesCount,
      penaltiesAmount: penaltiesAmount,
      attendanceAmount: attendanceAmount,
      hrEvaluationAmount: hrEvaluationAmount,
      adminCommitmentAmount: adminCommitmentAmount,
      advance: advance,
    );
  }

  factory SalaryDetails.fromJson(Map<String, dynamic> json) {
    return SalaryDetails(
      rival: (json['rival'] as num).toDouble(),
      lieues: (json['lieues'] as List).map((e) => Lieue.fromJson(e)).toList(),
      bonuses: (json['bonuses'] as num).toDouble(),
      lateCount: LateCount.fromJson(json['lateCount']),
      absenceDays: json['absenceDays'],
      attendsDays: json['attendsDays'],
      basicSalary: BasicSalary.fromJson(json['basicSalary']),
      workedHours: WorkedHours.fromJson(json['workedHours']),
      nextRaiseDate: DateTime.parse(json['nextRaiseDate']),
      penaltiesCount: json['penaltiesCount'],
      penaltiesAmount: (json['penaltiesAmount'] as num).toDouble(),
      attendanceAmount: (json['attendanceAmount'] as num).toDouble(),
      hrEvaluationAmount: HREvaluationAmount.fromJson(
        json['hrEvaluationAmount'],
      ),
      adminCommitmentAmount: (json['adminCommitmentAmount'] as num).toDouble(),
      advance: (json['advance'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'rival': rival,
    'advance': advance,
    'lieues': lieues.map((e) => e.toJson()).toList(),
    'bonuses': bonuses,
    'lateCount': lateCount.toJson(),
    'absenceDays': absenceDays,
    'attendsDays': attendsDays,
    'basicSalary': basicSalary.toJson(),
    'workedHours': workedHours.toJson(),
    'nextRaiseDate': nextRaiseDate.toIso8601String(),
    'penaltiesCount': penaltiesCount,
    'penaltiesAmount': penaltiesAmount,
    'attendanceAmount': attendanceAmount,
    'hrEvaluationAmount': hrEvaluationAmount.toJson(),
    'adminCommitmentAmount': adminCommitmentAmount,
  };
}

class ShiftSalaryDetails extends SalaryDetailsBase {
  final int shiftsCount;
  final double shiftPrice;
  final double advance;
  final int cases;
  final int dyeCases;
  final double casesAmount;
  final double dyeAmount;
  final HREvaluationAmount hrEvaluation;
  final double detectedhrShiftAmount;
  final double bonuses;
  final double penaltiesCount;
  final double penalties;
  final double rivals;

  ShiftSalaryDetails({
    required this.shiftsCount,
    required this.shiftPrice,
    required this.cases,
    required this.dyeCases,
    required this.casesAmount,
    required this.dyeAmount,
    required this.hrEvaluation,
    required this.bonuses,
    required this.penalties,
    required this.rivals,
    required this.penaltiesCount,
    required this.detectedhrShiftAmount,
    required this.advance,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": "shifts",
      "shiftsCount": shiftsCount,
      "shiftPrice": shiftPrice,
      "cases": cases,
      "dyeCases": dyeCases,
      "casesAmount": casesAmount,
      "dyeAmount": dyeAmount,
      "hrEvaluation": hrEvaluation.toJson(),
      "bonuses": bonuses,
      "penalties": penalties,
      "rivals": rivals,
      "penaltiesCount": penaltiesCount,
      "advance": advance,
      "detectedhrShiftAmount": detectedhrShiftAmount,
    };
  }

  factory ShiftSalaryDetails.fromJson(Map<String, dynamic> json) {
    return ShiftSalaryDetails(
      shiftsCount: json['shiftsCount'],
      shiftPrice: (json['shiftPrice'] as num).toDouble(),
      cases: json['cases'],
      dyeCases: json['dyeCases'],
      casesAmount: (json['casesAmount'] as num).toDouble(),
      dyeAmount: (json['dyeAmount'] as num).toDouble(),
      hrEvaluation: HREvaluationAmount.fromJson(json['hrEvaluation']),
      bonuses: (json['bonuses'] as num).toDouble(),
      penalties: (json['penalties'] as num).toDouble(),
      rivals: (json['rivals'] as num).toDouble(),
      penaltiesCount: (json['penaltiesCount'] as num).toDouble(),
      detectedhrShiftAmount: (json['detectedhrShiftAmount'] as num).toDouble(),
      advance: (json['advance'] as num).toDouble(),
    );
  }
}

class Lieue {
  final String name;
  final double amount;

  Lieue({required this.name, required this.amount});

  factory Lieue.fromJson(Map<String, dynamic> json) =>
      Lieue(name: json['name'], amount: (json['amount'] as num).toDouble());

  Map<String, dynamic> toJson() => {'name': name, 'amount': amount};
}

class LateCount {
  final int total;
  final int quarter;
  final int fullDay;
  final int halfDay;

  LateCount({
    required this.total,
    required this.quarter,
    required this.fullDay,
    required this.halfDay,
  });

  factory LateCount.fromJson(Map<String, dynamic> json) => LateCount(
    total: json['total'],
    quarter: json['quarter'],
    fullDay: json['full_day'],
    halfDay: json['half_day'],
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'quarter': quarter,
    'full_day': fullDay,
    'half_day': halfDay,
  };
}

class BasicSalary {
  final double total;
  final double raises;
  final double salary;
  final double jobGrade;
  final double otherSalary;
  final double experienceSalary;

  BasicSalary({
    required this.total,
    required this.raises,
    required this.salary,
    required this.jobGrade,
    required this.otherSalary,
    required this.experienceSalary,
  });

  factory BasicSalary.fromJson(Map<String, dynamic> json) => BasicSalary(
    total: (json['total'] as num).toDouble(),
    raises: (json['raises'] as num).toDouble(),
    salary: (json['salary'] as num).toDouble(),
    jobGrade: (json['job_grade'] as num).toDouble(),
    otherSalary: (json['other_salary'] as num).toDouble(),
    experienceSalary: (json['experience_salary'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'raises': raises,
    'salary': salary,
    'job_grade': jobGrade,
    'other_salary': otherSalary,
    'experience_salary': experienceSalary,
  };
}

class WorkedHours {
  final double total;
  final double net;
  final double real;
  final double leave;
  final double overtime;
  double absent;
  final double deducted;
  final double forget;
  final double friday2;
  final double permission;
  final double fridayAndHoliday;

  WorkedHours({
    required this.total,
    required this.net,
    required this.real,
    required this.leave,
    required this.overtime,
    required this.friday2,
    required this.absent,
    required this.permission,
    required this.deducted,
    required this.fridayAndHoliday,
    required this.forget,
  });

  factory WorkedHours.fromJson(Map<String, dynamic> json) => WorkedHours(
    total: json['total'] as double,
    net: json['net'] as double,
    real: json['real'] as double,
    leave: json['leave'] as double,
    overtime: json['overtime'] as double,
    friday2: json['friday2'] as double,
    absent: json['absent'] as double,
    permission: json['permission'] as double,
    deducted: json['deducted'] as double,
    fridayAndHoliday: json['fridayAndHoliday'] as double,
    forget: json['forget'] as double,
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'absent': absent,
    'deducted': deducted,
    'friday2': friday2,
    'leave': leave,
    'net': net,
    'overtime': overtime,
    'permission': permission,
    'real': real,
    'fridayAndHoliday': fridayAndHoliday,
    'forget': forget,
  };
}

class HREvaluationAmount {
  final int score;
  final double amount;

  HREvaluationAmount({required this.score, required this.amount});

  factory HREvaluationAmount.fromJson(Map<String, dynamic> json) =>
      HREvaluationAmount(
        score: json['score'],
        amount: (json['amount'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {'score': score, 'amount': amount};
}
