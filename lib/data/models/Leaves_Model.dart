class LeaveModel {
  final int? id;
  final int employeeId;
  final String? employeeName;
  final String? departmentName;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  String status;
  final String? notes;
  final int? substituteEmployeeId;
  final String? substituteEmployeeName;
  final bool? managerApproved;
  final String? hrDecision;
  final String? profileImage;

  LeaveModel({
    this.id,
    required this.employeeId,
    this.employeeName,
    this.departmentName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.notes,
    this.substituteEmployeeId,
    this.substituteEmployeeName,
    this.managerApproved,
    this.hrDecision,
    this.profileImage,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'] ?? '',
      leaveType: json['type'] ?? '',
      departmentName: json['department_name'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'] ?? 'pending',
      notes: json['notes'],
      substituteEmployeeId: json['substitute_employee_id'],
      substituteEmployeeName: json['employee_sub_name'],
      managerApproved: json['manger_approved'],
      hrDecision: json['hr_decision'],
      profileImage: json['profile_image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'type': leaveType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': leaveType,
      'notes': notes,
      'substitute_employee_id': substituteEmployeeId,
      'manger_approved': managerApproved,
      'hr_decision': hrDecision,
    };
  }
}
