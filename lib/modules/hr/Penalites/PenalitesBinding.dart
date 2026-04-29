import 'package:get/get.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesController.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesRepo.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesServices.dart';

class Penalitesbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PenaltyService());
    Get.lazyPut(() => PenaltyRepository(Get.find()));
    Get.lazyPut(() => PenaltyController(Get.find()));
  }
}
