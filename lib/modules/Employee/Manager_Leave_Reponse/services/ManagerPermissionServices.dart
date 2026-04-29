import 'package:supabase_flutter/supabase_flutter.dart';

class ManagerPermissionServices {
  // جلب البيانات الخام من قاعدة البيانات
  Future<List<dynamic>> getDepartmentPermissions(
    int departmentId,
    String currentEmployeeId,
  ) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await Supabase.instance.client
        .from('permissions_view')
        .select()
        .eq('department_id', departmentId)
        .eq('is_manger', false)
        .neq('employee_id', currentEmployeeId)
        .isFilter('manager_response', null)
        .gte('perm_date', today)
        .order('created_at', ascending: false);
    print(response);

    return response as List<dynamic>;
  }

  // تحديث الحالة
  Future<void> updatePermissionStatus(int permissionId, bool status) async {
    await Supabase.instance.client
        .from('Permissions')
        .update({'Manager_response': status})
        .eq('id', permissionId);
  }
}
