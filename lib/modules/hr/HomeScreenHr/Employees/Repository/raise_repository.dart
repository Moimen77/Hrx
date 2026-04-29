import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IRaiseRepository {
  Future<void> addRaise({
    required int employeeId,
    required double amount,
    required DateTime effectiveDate,
  });
}

class RaiseRepository implements IRaiseRepository {
  final _supabase = Supabase.instance.client;

  @override
  Future<void> addRaise({
    required int employeeId,
    required double amount,
    required DateTime effectiveDate,
  }) async {
    await _supabase.from('EmployeeRaises').insert({
      'employee_id': employeeId,
      'raise_amount': amount,
      'effective_date': DateFormat('yyyy-MM-dd').format(effectiveDate),
    });
  }
}
