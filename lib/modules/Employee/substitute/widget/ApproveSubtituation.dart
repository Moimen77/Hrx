import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/substitute/controller/Substitute_Controller.dart';

class ApproveSubtituationButton extends GetView<SubstituteController> {
  const ApproveSubtituationButton({super.key, required this.leave});

  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => controller.acceptAsSubstitute(leave),
      icon: Icon(
        Icons.check,
        color: Colors.white,
        size: 18.spAdaptive(context),
      ),
      label: Text(
        'قبول',
        style: cairoStyle(
          fontcolor: Colors.white,
          fontSize: 14.spAdaptive(context),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(
          horizontal: 14.spAdaptive(context),
          vertical: 12.spAdaptive(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.spAdaptive(context)),
        ),
      ),
    );
  }
}
