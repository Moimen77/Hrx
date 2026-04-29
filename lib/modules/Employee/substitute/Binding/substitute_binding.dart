import 'package:get/get.dart';
import 'package:hrx/modules/Employee/substitute/controller/Substitute_Controller.dart';
import 'package:hrx/modules/Employee/substitute/repo/Substitute_repo.dart';
import 'package:hrx/modules/Employee/substitute/repo/SubtitutePermissionRepo.dart';
import 'package:hrx/modules/Employee/substitute/services/SubstituteServices.dart';
import 'package:hrx/modules/Employee/substitute/services/SubtitutePermissionServices.dart';

class SubstituteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubstituteService());
    Get.lazyPut(() => SubtitutePermissionServices());
    Get.lazyPut(() => Subtitutepermissionrepo(Get.find()));
    Get.lazyPut(() => SubstituteRepository(Get.find()));
    Get.lazyPut(() => SubstituteController(Get.find(), Get.find()));
  }
}
