import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class PermissionTypeDropdown extends GetView<PermissionRequestController> {
  const PermissionTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dropdownaddemployee(
        value: controller.selectedType.value,
        items: controller.permissionTypes.map((type) {
          return DropdownMenuItem(
            value: type['value'],
            child: Text(
              type['label']!,
              style: cairoStyle(fontSize: 14.spAdaptive(context)),
            ),
          );
        }).toList(),

        onChanged: (val) => controller.selectedType.value = val!,
        icon: Icons.keyboard_arrow_down,
        title: 'نوع الإذن',
      ),
    );
  }
}
