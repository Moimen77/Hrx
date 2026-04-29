import 'package:get/get.dart';
import 'package:hrx/modules/hr/EmployeeSalary/controller/SalaryController.dart';
import 'package:hrx/modules/hr/EmployeeSalary/repo/EmployeeSalaryRepo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SalaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalaryRepo(Supabase.instance.client));
    Get.lazyPut(() => SalaryController(Get.find()));
  }
}
