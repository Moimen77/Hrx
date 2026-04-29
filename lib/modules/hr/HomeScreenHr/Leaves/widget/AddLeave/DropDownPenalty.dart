import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';

class DropDownPenalty extends GetView<AddLeaveController> {
  const DropDownPenalty({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.leaveType.value != 'مرفوضة') {
        return const SizedBox.shrink();
      }
      return Column(
        children: [
          Dropdownaddemployee(
            onChanged: (v) {
              if (v != null) {
                controller.selectedPenalty.value = v;
              } else {
                controller.selectedPenalty.value = null;
              }
            },

            value: controller.selectedPenalty.value,
            items: controller.penaltyOptions
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e['value'],
                    child: Text(
                      e['label'],
                      textAlign: TextAlign.right,
                      style: cairoStyle(),
                    ),
                  ),
                )
                .toList(),
            title: 'اختر نوع الخصم',
            icon: Icons.money_off,
          ),
          const Gap(20),
        ],
      );
    });
  }
}
