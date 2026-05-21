import 'package:get/instance_manager.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/attendanceController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/repo/AttendanceArciveRepo.dart';
import 'package:hrx/modules/Employee/EmpAttendance/repo/AttendanceRepo.dart';
import 'package:hrx/modules/Employee/EmpAttendance/services/AttendanceArchive_Services.dart';
import 'package:hrx/modules/Employee/EmpAttendance/services/Attendance_services.dart';

class Attendancebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceService());
    Get.lazyPut(() => AttendanceRepository(Get.find()));
    Get.lazyPut(() => AttendanceArciveController(Get.find()));
  }
}

class RegisterAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceServices());
    Get.lazyPut(() => Attendancerepo(attendanceServices: Get.find()));
    Get.lazyPut(() => Attendancecontroller(repo: Get.find()));
  }
}
