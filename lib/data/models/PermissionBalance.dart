class EmployeePermissionBalance {
  final int employeeId;
  final int month;
  final int year;
  final int total;
  final int used;

  EmployeePermissionBalance({
    required this.employeeId,
    required this.month,
    required this.year,
    required this.total,
    required this.used,
  });

  factory EmployeePermissionBalance.fromJson(Map<String, dynamic> json) {
    return EmployeePermissionBalance(
      employeeId: json['employee_id'],
      month: json['month'],
      year: json['year'],
      total: json['total_permissions'],
      used: json['used_permissions'],
    );
  }
}
