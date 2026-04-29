import 'package:get/get.dart';
import 'package:hrx/modules/Department/controller/department_controller.dart';
import 'package:hrx/modules/Employee/EmpAttendance/Binding/AttendanceBinding.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/Binding/employee_leaves_binding.dart';
import 'package:hrx/modules/Employee/HomePage/binding/homePageBinding.dart';
import 'package:hrx/modules/Employee/HomeScreenEmployee/HomeScreenController.dart';
import 'package:hrx/modules/Employee/LeaveBalance/services/LeaveBalanceServices.dart';
import 'package:hrx/modules/Employee/Loans/LoadArciveBinding.dart';
import 'package:hrx/modules/Employee/Permissions/Binding/PermissionBinding.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileBinding.dart';

class Homescreenbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepartmentController(), fenix: true);
    Get.lazyPut(() => LeaveBalanceService(), fenix: true);
    Get.lazyPut<Homescreencontroller>(() => Homescreencontroller());
    Homepagebinding().dependencies();
    Attendancebinding().dependencies();
    EmployeeLeavesBinding().dependencies();
    Permissionbinding().dependencies();
    LoanArciveBinding().dependencies();
    Profilebinding().dependencies();
  }
}
