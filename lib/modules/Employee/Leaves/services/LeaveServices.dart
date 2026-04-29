import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaveService {
  final supabase = Supabase.instance.client;

  Future<void> requestLeave(LeaveModel leave) async {
    await supabase.from('Leaves').insert(leave.toJson());
  }

  Future<List<Map<String, dynamic>>> getManagers() async {
    final response = await supabase
        .from('employees_view')
        .select()
        .eq('is_manger', true);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<int> calculateWorkingDays({
    required DateTime startDate,
    required DateTime endDate,
    required int employeeId,
  }) async {
    final res = await supabase.rpc(
      'calculate_working_days',
      params: {
        'p_start_date': startDate.toIso8601String().split('T').first,
        'p_end_date': endDate.toIso8601String().split('T').first,
        'p_employee_id': employeeId,
      },
    );

    return res as int;
  }

  Future<List<Map<String, dynamic>>> getDepartmentEmployees(
    int departmentId,
  ) async {
    final response = await supabase
        .from('employees_view')
        .select()
        .eq('department_id', departmentId);
    return List<Map<String, dynamic>>.from(response);
  }
}
