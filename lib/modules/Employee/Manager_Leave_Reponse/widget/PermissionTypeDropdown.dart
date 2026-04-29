import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/form_helpers.dart';

class PermissionTypeDropdown extends GetView<PermissionRequestController> {
  const PermissionTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: formBoxDecoration(),
        child: DropdownButtonFormField<String>(
          value: controller.selectedType.value,
          items: controller.permissionTypes.map((type) {
            return DropdownMenuItem(
              value: type['value'],
              child: Text(type['label']!, style: cairoStyle()),
            );
          }).toList(),
          onChanged: (val) => controller.selectedType.value = val!,
          decoration: formInputDecoration(
            prefixIcon: Icons.category_outlined,
            hint: 'اختر النوع',
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ),
      ),
    );
  }
}
