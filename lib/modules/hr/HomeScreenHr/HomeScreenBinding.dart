import 'package:get/get.dart';
import 'package:hrx/modules/Department/controller/department_controller.dart';
import 'package:hrx/modules/hr/EmployeeSalary/binding/SalaryBinding.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/HomePageHr/repo/HomePageRepo.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/Binding/AttendanceBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/binding/EmployeesBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/HomeScreenController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/binding/leaveBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/Binding/permissionBinding.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';
import 'package:hrx/modules/hr/Loans/binding/LoanBinding.dart';
import 'package:hrx/modules/hr/officalHoliday/binding/officalHolidayBinding.dart';

import '../HomePageHr/services/HrServices.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Homescreencontroller());
    Get.put(DepartmentController(), permanent: true);
    Get.lazyPut(() => hrHomeServices());
    Get.lazyPut(() => HomeRepository(Get.find()));
    Get.lazyPut(() => HomeController(repo: Get.find()));
    Get.lazyPut(() => DepartmentController());
    Loanbinding().dependencies();
    Officalholidaybinding().dependencies();
    EmployeesBinding().dependencies();
    AttendanceBinding().dependencies();
    LeaveBinding().dependencies();
    PermissionBinding().dependencies();
    SalaryBinding().dependencies();
    Get.lazyPut(() => Hrcontroller());
  }
}
