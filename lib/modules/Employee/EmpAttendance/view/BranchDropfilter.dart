import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class BranchDropFilter extends GetView<AttendanceArciveController> {
  const BranchDropFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Dropdownaddemployee(
      title: 'الفرع',
      icon: Icons.store,
      value: controller.filter.branchId == null
          ? null
          : controller.branches
                .firstWhereOrNull(
                  (b) => b.id.toString() == controller.filter.branchId,
                )
                ?.name,
      onChanged: (value) {
        final selectedBranch = controller.branches.firstWhereOrNull(
          (b) => b.name == value,
        );
        controller.filter.branchId = selectedBranch?.id.toString();
      },
      items: controller.branches
          .map(
            (branch) =>
                DropdownMenuItem(value: branch.name, child: Text(branch.name)),
          )
          .toList(),
    );
  }
}
