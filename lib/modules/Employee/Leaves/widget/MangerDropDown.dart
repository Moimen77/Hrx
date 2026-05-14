import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';

import '../../../hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class MangerDropdown extends GetView<LeaveController> {
  const MangerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dropdownaddemployee(
        onChanged: (v) => controller.selectedManager.value = controller
            .managersList
            .where((element) => element.name == v)
            .first,
        items: controller.managersList
            .map(
              (e) => DropdownMenuItem(
                value: e.name,
                child: Text(
                  e.name ?? '',
                  style: cairoStyle(fontSize: 14.spAdaptive(context), fontweight: FontWeight.w600),
                ),
              ),
            )
            .toList(),

        title: 'المدير المسؤول',
        icon: Icons.manage_accounts,
        value: controller.selectedManager.value?.name,
      ),
    );
  }
}
