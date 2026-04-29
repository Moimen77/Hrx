import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';

class DropDownEmployee extends GetView<AddLeaveController> {
  const DropDownEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dropdownaddemployee(
        onChanged: (v) {
          controller.selectedEmployee = controller.employees.firstWhere(
            (e) => e.name == v,
          );
        },
        value: controller.selectedEmployee?.name,
        items: controller.employees
            .map(
              (EmployeeModel e) => DropdownMenuItem<String>(
                value: e.name,
                child: Text(
                  e.name ?? '',
                  textAlign: TextAlign.right,
                  style: cairoStyle(),
                ),
              ),
            )
            .toList(),
        title: 'أختار الموظف',
        icon: Icons.person_outline,
      ),
    );
  }
}
