import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddEmployeeController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class Addemployeebutton extends GetView<AddEmployeeController> {
  const Addemployeebutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Buttonapp(
        OnTap: () async {
          await controller.saveEmployee(context);
        },
        width: Get.width * 0.7,
        isloading: controller.isLoading.value,
        text: controller.mode == EmployeeViewMode.edit
            ? 'تعديل الموظف'
            : 'اضافة موظف جديد',
        Loadingtext: 'جاري الحفظ...',
      ),
    );
  }
}
