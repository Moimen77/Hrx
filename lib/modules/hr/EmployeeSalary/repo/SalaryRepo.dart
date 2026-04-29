import 'package:supabase_flutter/supabase_flutter.dart';

class SalaryRepo {
  final _supabase = Supabase.instance.client;

  /// Inserts a list of allowances into the 'lieues' table.
  Future<void> addAllowances(List<Map<String, dynamic>> allowances) async {
    try {
      await _supabase.from('lieues').insert(allowances);
    } catch (e) {
      // It's good practice to log the error and rethrow it.
      print("Error adding allowances in SalaryRepo: $e");
      rethrow;
    }
  }
}
