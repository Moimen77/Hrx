import 'package:get/get.dart';

import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceController());
  }
}
