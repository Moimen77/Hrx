import 'package:hrx/data/models/EmployeeTypeModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShiftService {
  final supabase = Supabase.instance.client;

  Future<List<EmployeeTypeModel>> getEmployeeTypesWithShifts() async {
    final response = await supabase.from('employee_types').select('''
          id,
          name,
          shifts (
            id,
            name,
            start_time,
            end_time
          )
        ''');

    return (response as List)
        .map((e) => EmployeeTypeModel.fromJson(e))
        .toList();
  }

  Future<void> updateShift({
    required int shiftId,
    required String name,
    required String startTime,
    required String endTime,
  }) async {
    await supabase
        .from('shifts')
        .update({'name': name, 'start_time': startTime, 'end_time': endTime})
        .eq('id', shiftId);
  }
}
