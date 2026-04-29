import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';

class LeavesStatusFilter extends GetView<LeaveController> {
  const LeavesStatusFilter(this.StatusTitle, {super.key});
  final String StatusTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.changeStatusFilter(StatusTitle),
      child: Obx(() {
        bool isSelected = controller.statusFilter.value == StatusTitle;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.spAdaptive(context),
            vertical: 5.spAdaptive(context),
          ),
          margin: EdgeInsets.symmetric(horizontal: 2.spAdaptive(context)),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xffd0e5f4)
                : const Color(0xffe5e7eb),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            StatusTitle,
            textAlign: TextAlign.center,
            style: cairoStyle(
              fontcolor: isSelected
                  ? const Color(0xff399adc)
                  : const Color(0xff454f5e),
              fontSize: 12.spAdaptive(context),
              fontweight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),
        );
      }),
    );
  }
}
