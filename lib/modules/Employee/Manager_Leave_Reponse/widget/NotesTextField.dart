import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/form_helpers.dart';

class NotesTextField extends GetView<PermissionRequestController> {
  const NotesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: formBoxDecoration(context),
      child: TextFormField(
        controller: controller.notesController,
        maxLines: 4,
        style: TextStyle(fontSize: 15.spAdaptive(context), fontFamily: 'cairo'),
        decoration: formInputDecoration(
          context: context,
          prefixIcon: Icons.edit_note,
          hint: 'اكتب سبب الإذن...',
        ),
      ),
    );
  }
}
