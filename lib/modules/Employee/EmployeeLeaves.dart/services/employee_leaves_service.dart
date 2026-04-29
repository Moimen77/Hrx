import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeLeavesService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMyLeaves(int employeeId) async {
    final response = await supabase
        .from('leaveView') // استخدام leaveView لضمان توافق البيانات مع الموديل
        .select()
        .eq('employee_id', employeeId)
        .order('start_date', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<int> getPageCount(int empid, int departmentid) async {
    final String today = DateTime.now().toIso8601String().split('T')[0];
    final response = await supabase
        .from('leaveView')
        .select()
        .eq('department_id', departmentid)
        .eq('is_manger', false)
        .neq('employee_id', empid)
        .isFilter('manger_approved', null)
        .gte('start_date', today);

    return response.length;
  }
}
