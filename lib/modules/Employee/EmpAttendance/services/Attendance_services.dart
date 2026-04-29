import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceServices {
  final client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getBranches() async {
    final res = await client.from('branches').select();
    return res;
  }

  Future<List<Map<String, dynamic>>> getShifts(String employeeType) async {
    final res = await client
        .from('shifts')
        .select('*, employee_types!inner(name)')
        .eq('employee_types.name', employeeType);

    return res;
  }

  Future<void> checkIn(int employeeId, int branchId, int shiftId) async {
    await client.rpc(
      'checkin_employee',
      params: {
        'emp_id': employeeId,
        'branch_id': branchId,
        'shift_id': shiftId,
      },
    );
  }
}
