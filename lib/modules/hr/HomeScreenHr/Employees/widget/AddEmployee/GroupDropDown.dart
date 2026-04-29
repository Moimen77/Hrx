import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddEmployeeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class Groupdropdown extends GetView<AddEmployeeController> {
  const Groupdropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.availableDepartments.isEmpty) {
            return const CircularProgressIndicator();
          }
          return Dropdownaddemployee<int>(
            value: controller.selectedDepartment.value?.id,
            onChanged: (val) {
              controller.selectedDepartment.value = controller
                  .availableDepartments
                  .firstWhere((d) => d.id == val);
            },
            items: controller.availableDepartments.map((department) {
              return DropdownMenuItem<int>(
                value: department.id,
                child: Text(department.name),
              );
            }).toList(),

            title: 'القسم',
            icon: Icons.apartment_outlined,
          );
        }),
        const Gap(16),
        Dropdownaddemployee(
          value: controller.status.value,
          onChanged: controller.setStatus,
          items: [
            DropdownMenuItem(
              value: 'Active',
              child: Text("نشط", style: cairoStyle()),
            ),
            DropdownMenuItem(
              value: 'inactive',
              child: Text("غير نشط", style: cairoStyle()),
            ),
          ],
          title: 'حالة الموظف',
          icon: Icons.person_outline_outlined,
        ),
        const Gap(16),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings_outlined,
                      color: Appcolors.primarycolor,
                    ),
                    const Gap(12),
                    Text(
                      'تعيين كمدير',
                      style: cairoStyle(
                        fontcolor: Appcolors.primarycolor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: controller.isManager.value,
                  onChanged: (val) => controller.isManager.value = val,
                  activeColor: Appcolors.primarycolor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
