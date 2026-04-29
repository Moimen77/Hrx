import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/repo/LeaveRepostory.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/services/LeaveServices.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveService());
    Get.lazyPut(() => LeaveRepository(service: Get.find()));
    Get.lazyPut(() => LeaveController(repo: Get.find()));
  }
}
