import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';

class Datetimepickerfield extends GetView<AttendanceController> {
  const Datetimepickerfield(this.widget, {super.key});
  final double widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget,
      child: GestureDetector(
        onTap: () async {
          await controller.pickDate(context);
        },
        child: Filtercard(
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    "${controller.selectedDate.year}-${controller.selectedDate.month}-${controller.selectedDate.day}",
                    style: cairoStyle(
                      fontSize: 14.spAdaptive(context),
                      fontweight: FontWeight.w700,
                      fontcolor: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),

              Icon(Icons.calendar_month, size: 20.spAdaptive(context)),
            ],
          ),
        ),
      ),
    );
  }
}
