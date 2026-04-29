import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hrx/modules/hr/Bonuses/BonusController.dart';
import 'package:hrx/modules/hr/Bonuses/BonusRepo.dart';
import 'package:hrx/modules/hr/Bonuses/BonusServices.dart';

class Bonusbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BonusService());
    Get.lazyPut(() => BonusRepository(Get.find()));
    Get.lazyPut(() => BonusController(Get.find()));
  }
}
