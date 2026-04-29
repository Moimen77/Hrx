import 'package:hrx/data/models/AttendanceFilter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> fetchAttendance({
    required int employeeId,
    required AttendanceFilter filter,
  }) async {
    final response = await supabase.rpc(
      'employee_attendance_table',
      params: {
        'p_employee_id': employeeId,
        'p_start_date': filter.fromDate != null
            ? filter.fromDate!.toIso8601String().split('T').first
            : DateTime.now()
                  .subtract(const Duration(days: 30))
                  .toIso8601String()
                  .split('T')
                  .first,
        'p_end_date': filter.toDate != null
            ? filter.toDate!.toIso8601String().split('T').first
            : DateTime.now().toIso8601String().split('T').first,
      },
    );

    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);

    if (filter.branchId != null) {
      data = data
          .where((e) => e['branch_id'].toString() == filter.branchId.toString())
          .toList();
    }

    if (filter.status != null) {
      data = data.where((e) => e['day_status'] == filter.status).toList();
    }

    data.sort((a, b) {
      final aDate = a['work_date'] ?? '';
      final bDate = b['work_date'] ?? '';
      return bDate.compareTo(aDate);
    });
    print('data: $data');
    return data;
  }

  Future<List<Map<String, dynamic>>> getBranches() async {
    return await supabase.from("branches").select();
  }
}
