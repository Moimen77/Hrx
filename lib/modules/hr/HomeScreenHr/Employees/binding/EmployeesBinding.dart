import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/Repository/EmployeeRepository.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import '../services/supabase_employee_service.dart';

class EmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupabaseEmployeeService());
    Get.lazyPut(() => EmployeeRepository(Get.find()));
    Get.lazyPut(() => EmployeesController(Get.find()));
  }
}
