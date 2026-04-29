import 'package:hrx/data/models/activityModel.dart';

class HomeStatisticsModel {
  final int pendingPermissions;
  final int pendingLeaves;
  final double totalSalaries;
  final int totalEmployees;
  List<ActivityLogModel>? recentActivities;

  HomeStatisticsModel({
    required this.pendingPermissions,
    required this.pendingLeaves,
    required this.totalSalaries,
    required this.totalEmployees,
    this.recentActivities,
  });

  factory HomeStatisticsModel.fromJson(Map<String, dynamic> json) {
    return HomeStatisticsModel(
      pendingPermissions: json['pending_permissions'] ?? 0,
      pendingLeaves: json['pending_leaves'] ?? 0,
      totalSalaries: (json['last_month_basic_salary_total'] ?? 0).toDouble(),
      totalEmployees: json['active_employees'] ?? 0,
    );
  }
}
