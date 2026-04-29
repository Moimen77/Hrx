import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/form_helpers.dart';

class PermissionDateSelector extends GetView<PermissionRequestController> {
  const PermissionDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.selectDate(context),
      borderRadius: BorderRadius.circular(12),
      child: Obx(
        () => Container(
          decoration: formBoxDecoration(),
          child: InputDecorator(
            decoration: formInputDecoration(
              prefixIcon: Icons.calendar_today_outlined,
              hint: 'اختر التاريخ',
            ),
            child: Text(
              controller.selectedDate.value == null
                  ? 'اختر التاريخ'
                  : TimeHelper.formatDateToArabic(
                      controller.selectedDate.value!,
                    ),
              style: cairoStyle(
                fontcolor: controller.selectedDate.value == null
                    ? Colors.grey[600]
                    : Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
