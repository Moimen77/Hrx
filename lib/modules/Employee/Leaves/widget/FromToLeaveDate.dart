import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/widget/DatePickerField.dart';

class FromToLeaveDate extends GetView<LeaveController> {
  const FromToLeaveDate({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide =
        Responsive.isDesktop(context) || Responsive.isTablet(context);

    final startField = DatePickerField(
      label: "من تاريخ",
      date: controller.startDate,
      onDateSelected: (date) => controller.startDate.value = date,
      icon: Icons.calendar_month,
    );

    final endField = DatePickerField(
      label: "إلى تاريخ",
      date: controller.endDate,
      onDateSelected: (date) => controller.endDate.value = date,
      firstDate: controller.startDate.value,
      icon: Icons.event_available,
    );

    if (isWide) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: startField),
              SizedBox(width: 12.spAdaptive(context)),
              Expanded(child: endField),
            ],
          ),
          SizedBox(height: 20.spAdaptive(context)),
        ],
      );
    }

    return Column(
      children: [
        startField,
        SizedBox(height: 20.spAdaptive(context)),
        endField,
        SizedBox(height: 20.spAdaptive(context)),
      ],
    );
  }
}
