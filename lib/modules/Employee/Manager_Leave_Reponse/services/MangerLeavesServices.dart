// f:\Flutter\hrx_employees\lib\modules\Manager_Leave_Reponse\services\Manager_Leaves_Service.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class ManagerLeavesService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<dynamic>> getPendingLeaves(
    int departmentId,
    int currentEmployeeId,
  ) async {
    final String today = DateTime.now().toIso8601String().split('T')[0];
    final response = await client
        .from('leaveView')
        .select()
        .eq('status', 'معلقة')
        .eq('department_id', departmentId)
        .eq('is_manger', false)
        .neq('employee_id', currentEmployeeId)
        .isFilter('manger_approved', null)
        .gte('start_date', today);

    return response as List<dynamic>;
  }

  Future<void> updateLeaveStatus(int leaveId, String status) async {
    await client
        .from('Leaves')
        .update({'manger_approved': status == 'مقبولة' ? true : false})
        .eq('id', leaveId);
  }
}
