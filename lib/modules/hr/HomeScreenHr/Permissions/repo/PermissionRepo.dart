import 'package:hrx/modules/hr/HomeScreenHr/Permissions/services/PermissionServices.dart';

class PermissionRepo {
  final PermissionServices service;
  PermissionRepo(this.service);

  Future<List<dynamic>> getPermissions() async {
    return await service.getPermissions();
  }

  Future<void> updatePermissionStatus(int id, bool status) async {
    await service.updatePermissionStatus(id, status);
  }

  Future<void> deduct_perrmission(int employeeId) async {
    await service.deduct_perrmission(employeeId);
  }
}
