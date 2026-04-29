import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Permissions/controller/Permission_Controller.dart';
import 'package:hrx/modules/Employee/Permissions/repo/Permission_Repo.dart';
import 'package:hrx/modules/Employee/Permissions/services/Permission_services.dart';

class Permissionbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermissionServices());
    Get.lazyPut(() => PermissionRepo(Get.find()));
    Get.lazyPut(() => PermissionController(Get.find()));
  }
}
