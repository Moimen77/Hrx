import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/AddBranchDetailsController.dart';

class AddBranchLocationDeatils extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddBranchDetailsController());
  }
}
