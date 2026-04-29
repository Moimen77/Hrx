import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';

import '../../../hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class SubEmployeesDrowdown extends GetView<LeaveController> {
  const SubEmployeesDrowdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Dropdownaddemployee(
      onChanged: (v) => controller.selectedEmployee.value = controller
          .employeesList
          .where((element) => element.name == v)
          .first,

      items: controller.employeesList
          .map(
            (e) => DropdownMenuItem(
              value: e.name,
              child: Text(
                e.name ?? '',
                style: cairoStyle(fontSize: 14, fontweight: FontWeight.w600),
              ),
            ),
          )
          .toList(),
      title: 'الموظف البديل',
      icon: Icons.person,
      value: controller.selectedEmployee.value?.name,
    );
  }
}
