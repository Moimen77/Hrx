import 'package:get/instance_manager.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/repo/AttendanceArciveRepo.dart';
import 'package:hrx/modules/Employee/EmpAttendance/services/AttendanceArchive_Services.dart';

class Attendancebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceService());
    Get.lazyPut(() => AttendanceRepository(Get.find()));
    Get.lazyPut(() => AttendanceArciveController(Get.find()));
  }
}
