import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';

class LeaveReason extends GetView<AddLeaveController> {
  const LeaveReason({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.reasonController,
      style: cairoStyle(fontSize: 13.spAdaptive(context)),
      decoration: InputDecoration(
        labelText: 'السبب',
        labelStyle: cairoStyle(fontSize: 13.spAdaptive(context)),
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.spAdaptive(context),
          vertical: 16.spAdaptive(context),
        ),
        alignLabelWithHint: true,
      ),
      maxLines: 3,
    );
  }
}
