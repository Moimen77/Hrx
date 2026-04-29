import 'dart:ui' as dart_ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/LeavesStatusFilter.dart';

class Groupfiltersstatus extends GetView<LeaveController> {
  const Groupfiltersstatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          controller.statusList.length,
          (index) => LeavesStatusFilter(controller.statusList[index]),
        ),
      ),
    );
  }
}
