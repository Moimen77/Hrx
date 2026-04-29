class LieuesModel {
  final int id;
  final String name;
  final int amount;
  final int employeeId;
  final int month;
  final int year;

  LieuesModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.employeeId,
    required this.month,
    required this.year,
  });

  factory LieuesModel.fromJson(Map<String, dynamic> json) {
    return LieuesModel(
      id: json['id'],
      name: json['lieue_name'] ?? '',
      amount: json['lieue_amount'] ?? 0,
      employeeId: json['employee_id'],
      month: json['lieue_month'],
      year: json['lieue_year'],
    );
  }
}
