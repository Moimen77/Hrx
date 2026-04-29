import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEmployeeService {
  final _client = Supabase.instance.client;

  Future<List<EmployeeModel>> getEmployees() async {
    final res = await _client.from('employees_view').select();
    return res.map((e) => EmployeeModel.fromMap(e)).toList();
  }

  Future<void> addEmployee(Map<String, dynamic> emp, String password) async {
    await _client.functions.invoke(
      'quick-action',
      body: {'email': emp['email'], 'password': password, 'employeeData': emp},
    );
  }

  Future<void> updateEmployee(Map<String, dynamic> emp, int id) async {
    await _client.from('Employees').update(emp).eq('id', id);
  }

  Future<void> deleteEmployee(String id) async {
    await _client.from('Employees').delete().eq('id', id);
  }

  Future<List<Map<String, dynamic>>> getDepartments() async {
    final res = await _client.from('departments').select();
    print(res);
    return res;
  }

  Future<void> addBonus({
    required int employeeId,
    required String reason,
    required double amount,
    required bool isPercentage,
    required DateTime date,
  }) async {
    await _client.from('bonuses').insert({
      'employee_id': employeeId,
      'reason': reason,
      'amount': amount,
      'is_percentage': isPercentage,
      'bonus_date': date.toIso8601String(),
    });
  }

  Future<void> addPenalty({
    required int employeeId,
    required String type,
    required String reason,
    required double amount,
    required bool isrival,
    required DateTime date,
  }) async {
    await _client.from('penalties').insert({
      'employee_id': employeeId,
      'type': type,
      'reason': reason,
      'amount_day': amount,
      'penalty_date': date.toIso8601String(),
      'is_rival': isrival,
    });
  }
}
