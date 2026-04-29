class AttendanceModel {
  final int id;
  final int employeeId;
  final String employeeName;
  final String departmentName;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String status;
  final String? notes;
  final String? profileImage;

  AttendanceModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.departmentName,
    this.checkIn,
    this.checkOut,
    required this.status,
    this.notes,
    this.profileImage,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'] ?? '',
      departmentName: json['department_name'] ?? '',
      checkIn: json['check_in'] != null
          ? DateTime.parse(json['check_in']).toLocal()
          : null,
      checkOut: json['check_out'] != null
          ? DateTime.parse(json['check_out']).toLocal()
          : null,
      status: json['status'] ?? 'غائب',
      notes: json['notes'] ?? '',
      profileImage: json['profile_image'],
    );
  }
}
