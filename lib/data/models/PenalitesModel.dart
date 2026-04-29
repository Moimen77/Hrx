import 'package:hrx/data/models/EmployeeModel.dart';

class PenaltyModel {
  final int id;
  final int employeeId;
  final EmployeeModel? employee;
  final String type;
  final String reason;
  final double amountDay;
  final bool isRival;
  final DateTime penaltyDate;
  final String status;
  final DateTime? createdAt;

  PenaltyModel({
    required this.id,
    required this.employeeId,
    this.employee,
    required this.type,
    required this.reason,
    required this.amountDay,
    required this.isRival,
    required this.penaltyDate,
    required this.status,
    this.createdAt,
  });

  factory PenaltyModel.fromJson(Map<String, dynamic> json) {
    return PenaltyModel(
      id: json['id'],
      employeeId: json['employee_id'],
      employee: json['employee'] != null
          ? EmployeeModel.fromMap(json['employee'])
          : null,
      type: json['type'],
      reason: json['reason'],
      amountDay: (json['amount_day'] as num).toDouble(),
      isRival: json['is_rival'] ?? false,
      penaltyDate: DateTime.parse(json['penalty_date']),
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  String get displayValue {
    return isRival
        ? '${amountDay.toStringAsFixed(2)} EGP'
        : '${amountDay.toStringAsFixed(0)} يوم';
  }
}
