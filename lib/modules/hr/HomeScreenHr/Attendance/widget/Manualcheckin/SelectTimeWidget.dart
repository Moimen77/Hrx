import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/checkinController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/whiteCard.dart';

class Selecttimewidget extends GetView<ManualAttendanceController> {
  const Selecttimewidget(this.isSmall, {super.key});
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectTime(context),
        child: Whitecard(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          child: Text(
            controller.selectedTime.value.format(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Appcolors.primarycolor,
              fontWeight: FontWeight.bold,
              fontSize: isSmall ? 26 : 32,
            ),
          ),
        ),
      ),
    );
  }
}
