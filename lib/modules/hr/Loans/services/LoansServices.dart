import 'package:supabase_flutter/supabase_flutter.dart';

class AdvanceArchiveService {
  final client = Supabase.instance.client;

  Future<dynamic> fetchAdvancesForEmployee() async {
    final response = await client.from('loan_view').select();
    return response;
  }

  Future<void> updateLoanStatus(
    int id,
    String status,
    double? approvedAmount,
  ) async {
    await client
        .from('employee_advances')
        .update({
          'status': status,
          if (approvedAmount != null) 'approved_amount': approvedAmount,
          'response_date': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }
}
