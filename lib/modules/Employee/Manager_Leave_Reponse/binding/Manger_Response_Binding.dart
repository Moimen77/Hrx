// f:\Flutter\hrx_employees\lib\modules\ManagerLeaves\binding\ManagerLeavesBinding.dart

import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/Manger_Leave_Response.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/repo/Manger_reponse_repo.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/services/MangerLeavesServices.dart';

class ManagerLeavesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerLeavesService>(() => ManagerLeavesService());
    Get.lazyPut<ManagerLeavesRepository>(
      () => ManagerLeavesRepository(Get.find()),
    );
    Get.lazyPut<ManagerLeavesController>(
      () => ManagerLeavesController(Get.find()),
    );
  }
}
