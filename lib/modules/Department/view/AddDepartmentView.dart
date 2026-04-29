import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Auth/widget/AlignRightText.dart';
import 'package:hrx/modules/Department/view/add_department_controller.dart';
import 'package:hrx/modules/Department/widget/AddDepartment/ButtonAddDepartment.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddDepartmentScreen extends StatelessWidget {
  const AddDepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddDepartmentController());
    return Scaffold(
      appBar: CustomAppBar(title: 'إضافة قسم جديد'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Alignrighttext(text: 'اسم القسم'),
                const SizedBox(height: 8),
                Textfieldapp(
                  controller: controller.nameController,
                  hint: 'اكتب اسم القسم هنا...',
                  suffixIcon: Icon(Icons.category),
                ),
                const SizedBox(height: 24),
                ButtonAddDepartment(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
