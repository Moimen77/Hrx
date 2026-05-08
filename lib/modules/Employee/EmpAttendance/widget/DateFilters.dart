import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/shared_widgets/DateTimePickerField.dart';

class DateFilters extends GetView<AttendanceArciveController> {
  const DateFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isWide =
            Responsive.isDesktop(context) || Responsive.isTablet(context);

        final fromField = Datetimepickerfield(
          text: controller.fromDate.value == null
              ? 'من تاريخ'
              : formatDayMonth(controller.fromDate.value!),
          150,
          onTap: () async {
            await controller.selectDateRange(context);
          },
        );

        final toField = Datetimepickerfield(
          text: controller.fromDate.value == null
              ? 'إلي تاريخ'
              : formatDayMonth(controller.toDate.value!),
          150,
          onTap: () async {
            await controller.selectDateRange(context);
          },
        );

        if (isWide) {
          return Row(
            children: [
              Expanded(child: fromField),
              SizedBox(width: 10.spAdaptive(context)),
              Expanded(child: toField),
            ],
          );
        }

        return Column(
          children: [
            SizedBox(width: double.infinity, child: fromField),
            SizedBox(height: 10.spAdaptive(context)),
            SizedBox(width: double.infinity, child: toField),
          ],
        );
      },
    );
  }
}
