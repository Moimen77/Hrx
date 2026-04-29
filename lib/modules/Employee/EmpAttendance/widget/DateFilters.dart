import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/shared_widgets/DateTimePickerField.dart';

class DateFilters extends GetView<AttendanceArciveController> {
  const DateFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Datetimepickerfield(
              text: controller.fromDate.value == null
                  ? 'من تاريخ'
                  : formatDayMonth(controller.fromDate.value!),
              150,
              onTap: () async {
                await controller.selectDateRange(context);
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Datetimepickerfield(
              text: controller.fromDate.value == null
                  ? 'إلي تاريخ'
                  : formatDayMonth(controller.toDate.value!),
              150,
              onTap: () async {
                await controller.selectDateRange(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
