import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';

class Leavestextfieldsearch extends GetView<LeaveController> {
  const Leavestextfieldsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Textfieldapp(
      controller: TextEditingController(),
      hint: '...ابحث عن إجازة موظف',
      suffixIcon: Icon(Icons.search, color: Colors.grey.shade600),
      onChanged: (value) {
        controller.changeSearch(value);
      },
    );
  }
}
