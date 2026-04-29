class HolidayModel {
  final int? id;
  final String name;
  final DateTime? holidayDate;
  final int? day;
  final int? month;
  final int? year;
  final bool isRecurring;

  HolidayModel({
    this.id,
    required this.name,
    this.holidayDate,
    this.day,
    this.month,
    this.year,
    required this.isRecurring,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      id: json['id'],
      name: json['name'],
      holidayDate: json['holiday_date'] != null
          ? DateTime.parse(json['holiday_date'])
          : null,
      day: json['day'],
      month: json['month'],
      year: json['year'],
      isRecurring: json['is_recurring'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'holiday_date': holidayDate?.toIso8601String(),
      'day': day,
      'month': month,
      'year': year,
      'is_recurring': isRecurring,
    };
  }
}
