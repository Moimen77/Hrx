import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/PermissionBalance.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/PermissionRequest/services/PermissionRequestServices.dart';

class PermissionRequestRepo {
  final PermissionRequestServices services;

  PermissionRequestRepo(this.services);

  Future<void> submitPermission(PerrmissionModel permission) =>
      services.submitPermission(permission);

  Future<List<EmployeeModel>> getEmployees() async {
    final response = await services.getEmployees();
    return response.map((e) => EmployeeModel.fromMap(e)).toList();
  }

  Future<EmployeePermissionBalance> getEmployeePermissionBalance(
    int employeeId,
  ) async {
    final response = await services.getCurrentPermissionBalance(employeeId);
    return EmployeePermissionBalance.fromJson(response!);
  }
}
