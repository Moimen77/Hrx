import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/statusBadge.dart';

class TodayAttendanceStatus extends GetView<Homepagecontroller> {
  const TodayAttendanceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        Text(
          'حضور اليوم',
          style: cairoStyle(
            fontSize: 18.spAdaptive(context),
            fontweight: FontWeight.bold,
          ),
        ),
        if (controller.attendance != null)
          Statusbadge(attendance: controller.attendance!)
        else
          Text(
            'لم يتم التسجيل',
            style: cairoStyle(
              fontSize: 14.spAdaptive(context),
              fontcolor: Colors.grey.shade600,
            ),
          ),
      ],
    );
  }
}
