import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/checkinController.dart';

class Manualcheckinbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManualAttendanceController());
  }
}
