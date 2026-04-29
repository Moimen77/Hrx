import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';

class DropDownLeaveSubType extends GetView<AddLeaveController> {
  const DropDownLeaveSubType({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.leaveType.value != 'مقبولة') {
        return const SizedBox.shrink();
      }
      return Column(
        children: [
          Dropdownaddemployee(
            onChanged: (v) {
              if (v != null) {
                controller.selectedLeaveSubType.value = v;
              }
            },
            value: controller.selectedLeaveSubType.value,
            items: controller.leaveSubTypeOptions
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      textAlign: TextAlign.right,
                      style: cairoStyle(),
                    ),
                  ),
                )
                .toList(),
            title: 'نوع الأجازة (عارضة / اعتيادي)',
            icon: Icons.category,
          ),
          const Gap(20),
        ],
      );
    });
  }
}
