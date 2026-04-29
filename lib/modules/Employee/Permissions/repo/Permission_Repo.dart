import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/Permissions/services/Permission_services.dart';

class PermissionRepo {
  PermissionRepo(this.permissionServices);
  PermissionServices permissionServices;
  Future<List<PerrmissionModel>> getPermissions(int currentUserId) async {
    final response = await permissionServices.getPermissions(currentUserId);
    return response.map((e) => PerrmissionModel.fromJson(e)).toList();
  }

  Future<int> getPermissionsRequestsCount(
    int currentUserId,
    int departmentId,
  ) async {
    return await permissionServices.getPermissionsRequestsCount(
      currentUserId,
      departmentId,
    );
  }
}
