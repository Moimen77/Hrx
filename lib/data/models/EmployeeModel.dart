class EmployeeModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? employeeType;
  final double? shiftPrice;
  final double? salary;
  final String? status;
  final DateTime? createdAt;
  final int? departmentId;
  final String? departmentName;
  final String? userId;
  final bool? isManger;
  final DateTime? appointmentDate;
  final String? qualification;
  final int? yearsNumberEmployement;
  final int? jobGrade;
  final int? experienceSalary;
  final int? otherSalary;
  final int? totalRaises;
  final String? imageUrl;

  EmployeeModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.salary,
    required this.status,
    required this.departmentId,
    this.departmentName,
    this.userId,
    this.totalRaises,
    this.isManger,
    this.appointmentDate,
    this.qualification,
    this.yearsNumberEmployement,
    this.jobGrade,
    this.experienceSalary,
    this.otherSalary,
    this.createdAt,
    this.imageUrl,
    required this.employeeType,
    this.shiftPrice,
  });

  factory EmployeeModel.fromMap(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      salary: (json['salary']) != null
          ? (json['salary'] as num).toDouble()
          : 0.0,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      departmentId: json['department_id'] ?? json['department_id'],
      departmentName: json['department_name'],
      userId: json['user_id'],
      isManger: json['is_manger'],
      appointmentDate: json['AppointmentDate'] != null
          ? DateTime.parse(json['AppointmentDate'])
          : null,
      qualification: json['qualification'] ?? 'لا يوجد',
      yearsNumberEmployement: json['years_number_employement'] ?? 0,
      jobGrade: json['job_grade'] != null
          ? (json['job_grade'] as num).toInt()
          : 0,
      experienceSalary: json['experience_salary'] != null
          ? (json['experience_salary'] as num).toInt()
          : 0,
      totalRaises: json['total_raises'] != null
          ? (json['total_raises'] as num).toInt()
          : 0,
      otherSalary: json['other_salary'] != null
          ? (json['other_salary'] as num).toInt()
          : 0,
      employeeType: json['employee_type'] ?? 'full_time',
      shiftPrice: json['shiftPrice'] != null
          ? (json['shiftPrice'] as num).toDouble()
          : 0.0,
      imageUrl: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'salary': 0,
      'status': status,
      'department_id': departmentId,
      'is_manger': isManger,
      'AppointmentDate': appointmentDate?.toIso8601String(),
      'qualification': qualification,
      'years_number_employement': yearsNumberEmployement,
      'job_grade': jobGrade,
      'experience_salary': experienceSalary,
      'other_salary': otherSalary,
      'employee_type': employeeType,
      'shiftPrice': shiftPrice,
    };
  }
}
