import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/Branches_Controller.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/widget/BranchView/BranchCard.dart';

class ListBranchCard extends GetView<BranchesController> {
  const ListBranchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: controller.branches.length,
      itemBuilder: (context, i) {
        final branch = controller.branches[i];
        return BranchCard(branch: branch);
      },
    );
  }
}
