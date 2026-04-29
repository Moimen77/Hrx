import 'package:get/get.dart';
import '../controller/ManagerPermissionController.dart';
import '../repo/ManagerPermissionRepo.dart';
import '../../Manager_Leave_Reponse/services/ManagerPermissionServices.dart';

class ManagerPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManagerPermissionServices());
    Get.lazyPut<ManagerPermissionRepo>(() => ManagerPermissionRepo(Get.find()));
    Get.lazyPut<ManagerPermissionController>(
      () => ManagerPermissionController(Get.find()),
    );
  }
}
