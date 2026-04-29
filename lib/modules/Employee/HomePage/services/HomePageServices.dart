// ignore_for_file: non_constant_identifier_names

import 'package:supabase_flutter/supabase_flutter.dart';

class HomepageServices {
  final client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getEmployeeProfileData() async {
    String uid = client.auth.currentUser!.id;
    final res = await client.from('employees_view').select().eq('user_id', uid);
    return res;
  }

  Future<int> getPageCount(int emp_id, int department_id) async {
    final String today = DateTime.now().toIso8601String().split('T')[0];
    int count = 0;
    final response1 = await client
        .from('permissions_view')
        .select()
        .eq('department_id', department_id)
        .isFilter('sub_employee_id', null)
        .neq('employee_id', emp_id)
        .gte('perm_date', today);
    final response2 = await client
        .from('leaveView')
        .select()
        .eq('department_id', department_id)
        .neq('employee_id', emp_id)
        .isFilter('substitute_employee_id', null)
        .gte('start_date', today);
    count = response1.length + response2.length;
    return count;
  }

  Future<List<Map<String, dynamic>>> GetAttendaceToday(int employeeId) async {
    final dateNow = DateTime.now();
    final res = await client.rpc(
      'employee_attendance_table',
      params: {
        'p_employee_id': employeeId,
        'p_end_date': dateNow.toIso8601String(),
        'p_start_date': dateNow.toIso8601String(),
      },
    );
    return List<Map<String, dynamic>>.from(res);
  }

  Future<void> CheckOut(int employeeId) async {
    await client.rpc('checkout_employee', params: {'emp_id': employeeId});
  }

  Future<List<Map<String, dynamic>>> getRecentActivities(int employeeId) async {
    final response = await client
        .from('activity_logs')
        .select()
        .eq('employee_id', employeeId);
    return response;
  }
}
