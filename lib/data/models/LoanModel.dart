class AdvanceModel {
  int? id;
  int? employeeId;
  String? employeeName;
  double? requestedAmount;
  double? approvedAmount;
  String? status;
  DateTime? requestDate;
  String? responseDate;
  String? note;
  int? year;
  int? month;
  String? imgUrl;

  AdvanceModel({
    this.id,
    this.employeeId,
    this.requestedAmount,
    this.approvedAmount,
    this.status,
    this.requestDate,
    this.responseDate,
    this.note,
    this.year,
    this.month,
    this.imgUrl,
  });

  AdvanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    // تحويل القيمة الرقمية بأمان
    requestedAmount = double.tryParse(json['requested_amount'].toString());
    approvedAmount = json['approved_amount'] != null
        ? double.tryParse(json['approved_amount'].toString())
        : null;
    status = json['status'];
    requestDate = DateTime.parse(json['request_date'].toString());
    employeeName = json['name'] ?? 'No name';
    responseDate = json['response_date'];
    note = json['note'];
    year = json['year'];
    month = json['month'];
    imgUrl = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (employeeId != null) data['employee_id'] = employeeId;
    data['requested_amount'] = requestedAmount;
    data['note'] = note;
    data['year'] = year;
    data['month'] = month;
    status = 'معلقة';
    requestDate = DateTime.now();
    return data;
  }
}
