import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/AddBranchLocationController.dart';

class AddBranchLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddBranchLocationController());
  }
}
