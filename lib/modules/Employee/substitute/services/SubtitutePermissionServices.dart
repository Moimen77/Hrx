import 'package:supabase_flutter/supabase_flutter.dart';

class SubtitutePermissionServices {
  final client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> fetchSubstitutePermissions(
    int departmentId,
    int currentEmployeeId,
  ) async {
    final String today = DateTime.now().toIso8601String().split('T')[0];
    final response = await client
        .from('permissions_view')
        .select()
        .eq('department_id', departmentId)
        .neq('employee_id', currentEmployeeId)
        .gte('perm_date', today)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
