import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';

import '../../../hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class LeaveTypeDropdown extends GetView<LeaveController> {
  const LeaveTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dropdownaddemployee(
        onChanged: (v) => controller.type.value = v!,
        items: ['اعتيادي', 'عارضة']
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Row(
                  children: [
                    Container(width: 6, height: 35, color: Colors.grey[300]),
                    SizedBox(width: 8),
                    Text(
                      e,
                      style: cairoStyle(
                        fontSize: 14,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),

        title: 'نوع الإجازة',
        icon: Icons.hotel,
        value: controller.type.value.isEmpty ? null : controller.type.value,
      ),
    );
  }
}
