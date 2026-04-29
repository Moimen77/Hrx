import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';

class Departmentfilterdropdown extends GetView<EmployeesController> {
  const Departmentfilterdropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton<String>(
          value: controller.selectedDepartment.value,
          onChanged: controller.updateSelectedDepartment,
          items: controller.departments.map<DropdownMenuItem<String>>((
            String value,
          ) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: cairoStyle()),
            );
          }).toList(),
          underline: const SizedBox(),
          icon: const Icon(Icons.filter_list),
        ),
      ),
    );
  }
}
