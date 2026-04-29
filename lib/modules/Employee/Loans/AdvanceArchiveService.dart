import 'package:supabase_flutter/supabase_flutter.dart';

class AdvanceArchiveService {
  final client = Supabase.instance.client;

  Future<dynamic> fetchAdvancesForEmployee(int employeeId) async {
    final response = await client
        .from('employee_advances')
        .select()
        .eq('employee_id', employeeId);

    return response;
  }
}
