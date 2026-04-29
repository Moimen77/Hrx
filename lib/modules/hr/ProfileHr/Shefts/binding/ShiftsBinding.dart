import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/controller/ShiftController.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/repo/Sheft_Repo.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/services/shefts_Services.dart';

class Shiftsbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftController>(
      () => ShiftController(ShiftRepo(ShiftService())),
    );
  }
}
