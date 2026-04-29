import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/widget/DatePickerField.dart';

class FromToLeaveDate extends GetView<LeaveController> {
  const FromToLeaveDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePickerField(
          label: "من تاريخ",
          date: controller.startDate,
          onDateSelected: (date) => controller.startDate.value = date,
          icon: Icons.calendar_month,
        ),

        SizedBox(height: 20),

        // تاريخ النهاية
        DatePickerField(
          label: "إلى تاريخ",
          date: controller.endDate,
          onDateSelected: (date) => controller.endDate.value = date,
          firstDate: controller.startDate.value,
          icon: Icons.event_available,
        ),

        SizedBox(height: 20),
      ],
    );
  }
}
