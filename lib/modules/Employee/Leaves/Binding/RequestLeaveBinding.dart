import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/repo/LeaveRepo.dart';
import 'package:hrx/modules/Employee/Leaves/services/LeaveServices.dart';
class Requestleavebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveService());
    Get.lazyPut(() => LeaveRepository(Get.find(), Get.find()));
    Get.lazyPut(() => LeaveController(Get.find()));
  }
}
