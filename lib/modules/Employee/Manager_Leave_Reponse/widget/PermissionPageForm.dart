import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/DirectManagerSelector.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/NotesTextField.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/PermissionDateSelector.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/PermissionTypeDropdown.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SectionLabel.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SubmitPermissionButton.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SubstituteEmployeeSelector.dart';

class PermissionPageForm extends GetView<PermissionRequestController> {
  const PermissionPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Sectionlabel(title: 'نوع الإذن'),
            const SizedBox(height: 8),
            const PermissionTypeDropdown(),
            const SizedBox(height: 20),
            const Sectionlabel(title: 'تاريخ الإذن'),
            const SizedBox(height: 8),
            const PermissionDateSelector(),
            const SizedBox(height: 20),
            const Sectionlabel(title: 'الموظف البديل'),
            const SizedBox(height: 10),
            const SubstituteEmployeeSelector(),
            const SizedBox(height: 20),
            const DirectManagerSelector(),
            const SizedBox(height: 20),
            const Sectionlabel(title: 'ملاحظات'),
            const SizedBox(height: 8),
            const NotesTextField(),
            const SizedBox(height: 30),
            const SubmitPermissionButton(),
          ],
        ),
      ),
    );
  }
}
