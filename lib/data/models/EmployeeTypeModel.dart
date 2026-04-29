import 'package:hrx/core/function/translationFunctions.dart';
import 'package:hrx/data/models/ShiftsModel.dart';

class EmployeeTypeModel {
  final int id;
  final String name;
  final List<ShiftModel> shifts;

  EmployeeTypeModel({
    required this.id,
    required this.name,
    required this.shifts,
  });

  factory EmployeeTypeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeTypeModel(
      id: json['id'],
      name: translationFunctions.translationsShiftsTitle(json['name']),
      // name: json['name'],
      shifts: (json['shifts'] as List)
          .map((e) => ShiftModel.fromJson(e))
          .toList(),
    );
  }
}
