import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddEmployeeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/AddEmployeeButton.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/GroupDropDown.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/GroupTextFields.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({super.key});
  @override
  Widget build(BuildContext context) {
    final isEditMode = controller.mode == EmployeeViewMode.edit;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: isEditMode ? 'تعديل بيانات الموظف' : 'اضافة موظف جديد',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Grouptextfields(),
                const Gap(16),
                const Groupdropdown(),
                const Gap(30),
                const Addemployeebutton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
