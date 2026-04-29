import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/substitute/controller/Substitute_Controller.dart';
import 'package:hrx/modules/Employee/substitute/widget/DateInfoContatiner.dart';
import 'package:hrx/modules/Employee/substitute/widget/RequestSubTitle.dart';
import 'package:hrx/modules/Employee/substitute/widget/YouAreTheSubContainer.dart';
import 'package:hrx/modules/Employee/substitute/widget/actionSubtitutationBUttons.dart';

class LeaveCard extends GetView<SubstituteController> {
  const LeaveCard({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    final currentUserId = controller.homeController.Employee?.id;
    Widget statusWidget;

    if (leave.substituteEmployeeId == null) {
      statusWidget = ActionSubtitutationButtons(leave: leave);
    } else if (leave.substituteEmployeeId == currentUserId) {
      statusWidget = YouAreTheSubContainer(isSub: true, leave: leave);
    } else {
      statusWidget = YouAreTheSubContainer(isSub: false, leave: leave);
    }
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            RequestSubTitle(leave: leave),
            DateInfoContatiner(leave: leave),
            const Divider(),
            const SizedBox(height: 5),
            Center(child: statusWidget),
          ],
        ),
      ),
    );
  }
}
