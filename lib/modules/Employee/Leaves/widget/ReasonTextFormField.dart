import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';

class ReasonTextFormField extends GetView<LeaveController> {
  const ReasonTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (v) => controller.reason.value = v,
      style: cairoStyle(fontSize: 15.spAdaptive(context)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.edit_calendar,
          color: Appcolors.primarycolor,
          size: 20.spAdaptive(context),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.spAdaptive(context)),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.spAdaptive(context)),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.spAdaptive(context)),
          borderSide: BorderSide(color: Appcolors.primarycolor, width: 2),
        ),
        labelStyle: cairoStyle(
          fontcolor: Colors.grey[600],
          fontSize: 15.spAdaptive(context),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.spAdaptive(context),
          horizontal: 20.spAdaptive(context),
        ),
      ),
      maxLines: 3,
    );
  }
}
