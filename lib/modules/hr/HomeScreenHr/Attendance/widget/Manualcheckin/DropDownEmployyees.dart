import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/checkinController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/whiteCard.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class Dropdownemployyees extends GetView<ManualAttendanceController> {
  const Dropdownemployyees({super.key});

  @override
  Widget build(BuildContext context) {
    return Whitecard(
      child: Obx(
        () => Dropdownaddemployee(
          title: 'اختر الموظف',
          icon: Icons.person_outline,
          value:
              controller.employees.any(
                (e) => e.name == controller.selectedEmployee.value,
              )
              ? controller.selectedEmployee.value
              : null,
          items: controller.employees
              .map(
                (EmployeeModel e) => DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(
                    e.name ?? '',
                    style: cairoStyle(fontSize: 12.spAdaptive(context)),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            controller.selectedEmployee.value = v!;
          },
        ),
      ),
    );
  }
}
