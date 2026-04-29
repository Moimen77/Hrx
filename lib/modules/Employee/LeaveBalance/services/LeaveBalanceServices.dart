import 'package:supabase_flutter/supabase_flutter.dart';

class LeaveBalanceService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Map<String, dynamic>> getEmployeeLeaveBalance(int employeeId) async {
    final response = await _client
        .from('EmployeeLeaveBalance')
        .select()
        .eq('employee_id', employeeId)
        .order('period_start', ascending: false)
        .limit(1)
        .maybeSingle();
    print(response);
    return response!;
  }
}
