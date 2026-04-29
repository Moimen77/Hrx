import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/ListLeavesCard.dart';

class LeavesListDisplay extends GetView<LeaveController> {
  const LeavesListDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.leaves.isEmpty) {
        return Center(
          child: Text(
            "لا توجد إجازات",
            style: cairoStyle(
              fontSize: 20.spAdaptive(context),
              fontweight: FontWeight.w600,
            ),
          ),
        );
      }
      return Listleavescard();
    });
  }
}
