import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/controller/PermissionController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/repo/PermissionRepo.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/services/PermissionServices.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermissionServices());
    Get.lazyPut(() => PermissionRepo(Get.find()));
    Get.lazyPut(() => PermissionController(Get.find()));
  }
}
