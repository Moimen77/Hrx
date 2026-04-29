import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
      icon: Icon(Icons.check, color: Colors.white),
      label: Text('قبول', style: cairoStyle(fontcolor: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
