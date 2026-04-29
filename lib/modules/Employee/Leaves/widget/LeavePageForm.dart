import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/widget/LeaveRequestDetails.dart';
import 'package:hrx/modules/Employee/Leaves/widget/RequestLeaveButton.dart';
import 'package:hrx/modules/Employee/Leaves/widget/SubDetailsCard.dart';

class LeavePageForm extends GetView<LeaveController> {
  const LeavePageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: ListView(
            children: [
              SizedBox(height: 10),
              LeaveRequestDetails(),
              SizedBox(height: 10),
              SubDetailsCard(),
              SizedBox(height: 10),
              RequestLeaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
