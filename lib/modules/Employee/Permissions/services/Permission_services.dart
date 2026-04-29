// ignore_for_file: file_names

import 'package:supabase_flutter/supabase_flutter.dart';

class PermissionServices {
  final client = Supabase.instance.client;
  Future<List<dynamic>> getPermissions(int currentUserId) async {
    final response = await client
        .from('permissions_view')
        .select()
        .eq('employee_id', currentUserId);
    return List<dynamic>.from(response);
  }

  Future<int> getPermissionsRequestsCount(
    int currentUserId,
    int departmentId,
  ) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await client
        .from('permissions_view')
        .select()
        .eq('department_id', departmentId)
        .eq('is_manger', false)
        .neq('employee_id', currentUserId)
        .isFilter('manager_response', null)
        .gte('perm_date', today);
    return response.length;
  }
}
