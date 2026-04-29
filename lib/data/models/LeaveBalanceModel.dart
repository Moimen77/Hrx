class EmployeeLeaveBalance {
  final int employeeId;
  final int casualTotal;
  final int casualUsed;
  final int annualTotal;
  final int annualUsed;
  final DateTime periodStart;
  final DateTime periodEnd;

  EmployeeLeaveBalance({
    required this.employeeId,
    required this.casualTotal,
    required this.casualUsed,
    required this.annualTotal,
    required this.annualUsed,
    required this.periodStart,
    required this.periodEnd,
  });

  factory EmployeeLeaveBalance.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveBalance(
      employeeId: json['employee_id'],
      casualTotal: json['casual_total'],
      casualUsed: json['casual_used'],
      annualTotal: json['annual_total'],
      annualUsed: json['annual_used'],
      periodStart: DateTime.parse(json['period_start']),
      periodEnd: DateTime.parse(json['period_end']),
    );
  }
}
