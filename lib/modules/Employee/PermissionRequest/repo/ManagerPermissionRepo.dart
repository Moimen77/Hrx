import 'package:hrx/data/models/Perrmission_Model.dart';
import '../../Manager_Leave_Reponse/services/ManagerPermissionServices.dart';

class ManagerPermissionRepo {
  final ManagerPermissionServices services;
  ManagerPermissionRepo(this.services);

  // جلب الطلبات الخاصة بالقسم ما عدا طلبات المدير نفسه
  Future<List<PerrmissionModel>> getDepartmentPermissions(
    int departmentId,
    String currentEmployeeId,
  ) async {
    final response = await services.getDepartmentPermissions(
      departmentId,
      currentEmployeeId,
    );
    // تحويل البيانات إلى قائمة من PermissionModel
    return response.map((e) => PerrmissionModel.fromJson(e)).toList();
  }

  // تحديث حالة الطلب (قبول أو رفض)
  Future<void> updatePermissionStatus(int permissionId, bool status) async {
    await services.updatePermissionStatus(permissionId, status);
  }
}
