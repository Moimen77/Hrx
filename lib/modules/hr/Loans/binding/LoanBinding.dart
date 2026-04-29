import 'package:get/get.dart';
import 'package:hrx/modules/hr/Loans/controller/LoanController.dart';
import 'package:hrx/modules/hr/Loans/repo/LoanRepo.dart';
import 'package:hrx/modules/hr/Loans/services/LoansServices.dart';

class Loanbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvanceArchiveService());
    Get.lazyPut(() => AdvanceArchiveRepo(Get.find()));
    Get.lazyPut(() => AdvanceArchiveController(Get.find()));
  }
}
