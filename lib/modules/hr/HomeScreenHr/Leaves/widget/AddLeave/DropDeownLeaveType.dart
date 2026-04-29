import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';

class DropDeownLeaveType extends GetView<AddLeaveController> {
  const DropDeownLeaveType({super.key});

  @override
  Widget build(BuildContext context) {
    return Dropdownaddemployee(
      onChanged: (v) {
        controller.leaveType.value = controller.leaveTypes.firstWhere(
          (e) => e == v,
        );
      },
      value: controller.leaveType.value,
      items: controller.leaveTypes
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, textAlign: TextAlign.right, style: cairoStyle()),
            ),
          )
          .toList(),
      title: 'اختر نوع الإجازة',
      icon: Icons.hotel,
    );
  }
}
