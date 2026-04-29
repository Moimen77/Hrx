import 'package:get/get.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/controller/employee_leaves_controller.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/repo/employee_leaves_repo.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/services/employee_leaves_service.dart';
import 'package:hrx/modules/Employee/LeaveBalance/services/LeaveBalanceServices.dart';

class EmployeeLeavesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeLeavesService());
    Get.lazyPut(() => LeaveBalanceService());
    Get.lazyPut(() => EmployeeLeavesRepository(Get.find(), Get.find()));
    Get.lazyPut(() => EmployeeLeavesController(Get.find()));
  }
}
