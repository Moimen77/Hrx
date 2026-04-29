import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/form_helpers.dart';

class NotesTextField extends GetView<PermissionRequestController> {
  const NotesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: formBoxDecoration(),
      child: TextFormField(
        controller: controller.notesController,
        maxLines: 4,
        decoration: formInputDecoration(
          prefixIcon: Icons.edit_note,
          hint: 'اكتب سبب الإذن...',
        ),
      ),
    );
  }
}
