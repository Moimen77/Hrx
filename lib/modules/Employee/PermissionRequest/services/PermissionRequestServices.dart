import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PermissionRequestServices {
  final SupabaseClient client = Supabase.instance.client;

  // إرسال طلب الإذن
  Future<void> submitPermission(PerrmissionModel permission) async {
    await client.from('Permissions').insert(permission.toJson());
  }

  // جلب قائمة الموظفين لاختيار البديل والمدير
  Future<List<Map<String, dynamic>>> getEmployees() async {
    final response = await client
        .from('employees_view')
        .select()
        .order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getCurrentPermissionBalance(
    int employeeId,
  ) async {
    final datenow = DateTime.now();

    return await client
        .from('EmployeePermissionBalance')
        .select()
        .eq('employee_id', employeeId)
        .eq('month', datenow.month)
        .eq('year', datenow.year)
        .maybeSingle();
  }
}
