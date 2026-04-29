import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddEmployeeController.dart';

class Addemployeebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEmployeeController>(
      () => AddEmployeeController(),
      fenix: true,
    );
  }
}
