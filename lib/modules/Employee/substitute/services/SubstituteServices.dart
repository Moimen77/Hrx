// f:\Flutter\hrx_employees\lib\modules\Substitute\services\SubstituteService.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SubstituteService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getSubstituteLeaves(
    int departmentId,
    int currentEmployeeId,
  ) async {
    final String today = DateTime.now().toIso8601String().split('T')[0];
    final response = await supabase
        .from('leaveView')
        .select()
        .eq('department_id', departmentId)
        .neq('employee_id', currentEmployeeId)
        .gte('start_date', today)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> acceptAsSubstitute(
    int leaveId,
    int substituteId,
    String substituteName,
  ) async {
    await supabase
        .from('Leaves')
        .update({'substitute_employee_id': substituteId})
        .eq('id', leaveId);
  }
}
