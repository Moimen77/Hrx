import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/departmentmodel.dart';

import '../services/supabase_employee_service.dart';

class EmployeeRepository {
  final SupabaseEmployeeService service;

  EmployeeRepository(this.service);

  Future<List<EmployeeModel>> getEmployees() => service.getEmployees();
  Future<void> addEmployee(Map<String, dynamic> emp, String password) =>
      service.addEmployee(emp, password);
  Future<List<DepartmentModel>> getDepartments() async {
    final res = await service.getDepartments();
    return res.map((e) => DepartmentModel.fromJson(e)).toList();
  }

  Future<void> updateEmployee(Map<String, dynamic> emp, int id) =>
      service.updateEmployee(emp, id);
  Future<void> deleteEmployee(String id) => service.deleteEmployee(id);
  Future<void> createPenalty({
    required int employeeId,
    required String type,
    required String reason,
    required double amount,
    required bool isrival,
    required DateTime date,
  }) async {
    await service.addPenalty(
      employeeId: employeeId,
      type: type,
      reason: reason,
      amount: amount,
      isrival: isrival,
      date: date,
    );
  }

  Future<void> createBonus({
    required int employeeId,
    required String reason,
    required double amount,
    required bool isPercentage,
    required DateTime date,
  }) async {
    await service.addBonus(
      employeeId: employeeId,
      reason: reason,
      amount: amount,
      isPercentage: isPercentage,
      date: date,
    );
  }
}
