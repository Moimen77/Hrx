import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Loans/loanController.dart';
import 'package:hrx/modules/Employee/Loans/loanRepo.dart';
import 'package:hrx/modules/Employee/Loans/loanServices.dart';

class Loanbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvanceServices());
    Get.lazyPut(() => AdvanceRepo(Get.find()));
    Get.lazyPut(() => RequestAdvanceController(Get.find()));
  }
}
