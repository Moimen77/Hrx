import 'package:get/get.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_controller.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_repo.dart';

class Officalholidaybinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfficialHolidaysRepo());
    Get.lazyPut(() => OfficialHolidaysController(Get.find()));
  }
}
