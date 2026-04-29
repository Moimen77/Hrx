class ActivityLogModel {
  final String id;

  final String type;

  final String? employeeId;

  final String? performedBy;

  final Map<String, dynamic> metadata;

  final DateTime createdAt;

  ActivityLogModel({
    required this.id,
    required this.type,
    required this.metadata,
    this.employeeId,
    this.performedBy,
    required this.createdAt,
  });

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
      id: json['id'],

      type: json['type'],

      employeeId: json['employee_id'].toString(),

      performedBy: json['performed_by'],

      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : {},

      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'type': type,

      'employee_id': employeeId,

      'performed_by': performedBy,

      'metadata': metadata,

      'created_at': createdAt.toIso8601String(),
    };
  }
}
