import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/repo/PermissionRequestRepo.dart';
import 'package:hrx/modules/Employee/PermissionRequest/services/PermissionRequestServices.dart';

class PermissionRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermissionRequestServices());
    Get.lazyPut(() => PermissionRequestRepo(Get.find()));
    Get.lazyPut(() => PermissionRequestController(Get.find()));
  }
}
