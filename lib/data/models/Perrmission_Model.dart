// ignore_for_file: non_constant_identifier_names

class PerrmissionModel {
  final int? id;
  final int employeeId;
  final int? departmentid;
  final String? employeeName;
  final String perm_type;
  final DateTime perm_date;
  final int? substituteEmployeeId;
  final String? substituteEmployeeName;
  final bool? managerApproved;
  final bool? hr_approve;
  final String? notes;

  PerrmissionModel({
    this.departmentid,
    required this.perm_type,
    required this.perm_date,
    this.id,
    required this.employeeId,
    this.employeeName,
    this.notes,
    this.substituteEmployeeId,
    this.substituteEmployeeName,
    this.managerApproved,
    this.hr_approve,
  });

  factory PerrmissionModel.fromJson(Map<String, dynamic> json) {
    return PerrmissionModel(
      id: json['id'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      departmentid: json['department_id'],
      perm_type: json['perm_type'] == 'delay' ? 'إذن تأخير' : 'إذن مغادرة',
      perm_date: DateTime.parse(json['perm_date']),
      notes: json['notes'],
      substituteEmployeeId: json['sub_employee_id'],
      substituteEmployeeName: json['sub_employee_name'] ?? 'لم يتم توفير بديل',
      managerApproved: json['manager_response'],
      hr_approve: json['hr_approve'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'perm_type': perm_type,
      'Perm_date': perm_date.toIso8601String(),
      'notes': notes,
    };
  }
}
