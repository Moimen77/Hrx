import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class StatusFilter extends GetView<AttendanceArciveController> {
  const StatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Dropdownaddemployee(
      title: 'الحالة',
      icon: Icons.info_outline,
      value: controller.filter.status,
      onChanged: (value) {
        controller.filter.status = value;
      },
      items: controller.statuses
          .map(
            (status) => DropdownMenuItem(
              value: status,
              child: Text(controller.statusTranslations[status]!),
            ),
          )
          .toList(),
    );
  }
}
