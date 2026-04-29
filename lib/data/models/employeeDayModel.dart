// ignore_for_file: non_constant_identifier_names

import 'package:hrx/core/class/TimeHelper.dart';

class EmployeeDayModel {
  final int employeeId;
  final String employeeName;
  final String employeeType;
  final String department_name;
  final DateTime date;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? shift_name;
  final String? branch_name;
  final double? lat;
  final double? lng;
  final Duration? shift_start;
  final Duration? shift_end;
  final String status;
  final String? leaveType;
  final String? notes;
  final double? shiftPrice;
  final String? hr_leave_approve;
  final double? hrDecisionDay;
  final String? late_penalty_type;
  final int permission_minute;
  final int overtime;
  final String? profileImage;

  EmployeeDayModel({
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.status,
    this.leaveType,
    this.notes,
    this.hr_leave_approve,
    this.late_penalty_type,
    this.permission_minute = 0,
    required this.employeeId,
    required this.employeeType,
    this.hrDecisionDay,
    this.shiftPrice,
    required this.overtime,
    required this.department_name,
    this.profileImage,
    required this.employeeName,
    required this.shift_name,
    this.shift_start,
    this.shift_end,
    this.branch_name,
    this.lat,
    this.lng,
  });

  factory EmployeeDayModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDayModel(
      date: DateTime.parse(json['work_date']),
      checkIn: json['check_in'] != null
          ? DateTime.parse(json['check_in'])
          : null,
      checkOut: json['check_out'] != null
          ? DateTime.parse(json['check_out'])
          : null,
      status: json['day_status'],
      leaveType: json['leave_type'],
      notes: json['attendance_notes'] ?? json['leave_reason'],
      hr_leave_approve: json['hr_leave_approve'],
      late_penalty_type: json['late_penalty_type'],
      permission_minute: json['permission_minute'] ?? 0,
      employeeId: json['employee_id'],
      employeeType: json['employee_type'] ?? 'full_time',
      hrDecisionDay:
          json['hr_decision_days'] != null && json['hr_decision_days'] != ''
          ? double.parse(json['hr_decision_days'])
          : 0,
      shiftPrice: json['shift_price'] != null
          ? double.parse(json['shift_price'].toString())
          : 0,
      overtime: json['overtime_minute'] ?? 0,
      department_name: json['department_name'],
      profileImage: json['employeeimage'],
      employeeName: json['employeename'],
      shift_name: json['shift_name'] ?? '',
      shift_start: json['shift_start'] != null
          ? TimeHelper.toDuration(json['shift_start'])
          : null,
      branch_name: json['branch_name'],

      shift_end: json['shift_start'] != null
          ? TimeHelper.toDuration(json['shift_end'])
          : null,
      lat: json['branch_lat'],
      lng: json['branch_long'],
    );
  }
}
