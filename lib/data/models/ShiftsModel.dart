import 'package:hrx/core/class/TimeHelper.dart';

class ShiftModel {
  final int id;
  final String name;
  final String startTime;
  final String endTime;

  ShiftModel({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'],
      name: json['name'],
      startTime: TimeHelper.formatDurationToArabic(
        TimeHelper.toDuration(json['start_time']),
      ),
      endTime: TimeHelper.formatDurationToArabic(
        TimeHelper.toDuration(json['end_time']),
      ),
    );
  }
}
