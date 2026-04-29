import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeScreen/buildSummaryCard.dart';

class Pannersummary extends GetView<EmployeesController> {
  const Pannersummary({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = 12;
    final double horizontalPadding = 16;

    // نحسب ال width صح
    final double itemWidth =
        (Get.width - (horizontalPadding * 2) - (spacing * 2)) / 3;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(
        () => Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: itemWidth,
              child: Buildsummarycard(
                title: "إجمالي الموظفين",
                value: controller.totalEmployeesCount.toString(),
                icon: Icons.groups_2_outlined,
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: Buildsummarycard(
                title: "النشطون",
                value: controller.activeEmployeesCount.toString(),
                icon: Icons.person_outline_outlined,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: Buildsummarycard(
                title: "الأقسام",
                value: controller.departmentCount.toString(),
                icon: Icons.business_center_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
