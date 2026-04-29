import 'package:hrx/data/models/EmployeeModel.dart';

class BonusModel {
  final int id;
  final int employeeId;
  final EmployeeModel? employee;
  final String reason;
  final double amount;
  final bool isPercentage;
  final DateTime bonusDate;
  final String status;
  final DateTime? createdAt;

  BonusModel({
    required this.id,
    required this.employeeId,
    this.employee,
    required this.reason,
    required this.amount,
    required this.isPercentage,
    required this.bonusDate,
    required this.status,
    this.createdAt,
  });

  factory BonusModel.fromJson(Map<String, dynamic> json) {
    return BonusModel(
      id: json['id'],
      employeeId: json['employee_id'],
      employee: json['employee'] != null
          ? EmployeeModel.fromMap(json['employee'])
          : null,
      reason: json['reason'],
      amount: (json['amount'] as num).toDouble(),
      isPercentage: json['is_percentage'] ?? false,
      bonusDate: DateTime.parse(json['bonus_date']),
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
