import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveController.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveRepo.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveService.dart';

class LoanArciveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvanceArchiveService());
    Get.lazyPut(() => AdvanceArchiveRepo(Get.find()));
    Get.lazyPut(() => AdvanceArchiveController(Get.find()));
  }
}
