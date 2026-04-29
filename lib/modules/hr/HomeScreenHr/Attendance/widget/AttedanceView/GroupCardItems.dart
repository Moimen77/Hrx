import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/CardItem.dart';

class Groupcarditems extends GetView<AttendanceController> {
  const Groupcarditems({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxis = constraints.maxWidth < 600 ? 2 : 4;

        return GridView.count(
          crossAxisCount: crossAxis,
          shrinkWrap: true,
          crossAxisSpacing: 25,
          mainAxisSpacing: 8,
          mainAxisExtent: 80.spAdaptive(Get.context!),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Carditem(
              title: "إجمالي الموظفين",
              value: "${controller.total}",
              color: Appcolors.primarycolor,
              icon: Icons.groups_rounded,
            ),
            Carditem(
              title: "الحاضرين",
              value: "${controller.present}",
              color: Appcolors.success,
              icon: Icons.check_circle_outline,
            ),
            Carditem(
              title: "المتأخرين",
              value: "${controller.late}",
              color: Appcolors.warning,
              icon: Icons.access_time,
            ),
            Carditem(
              title: "الغياب",
              value: "${controller.absent}",
              color: Appcolors.error,
              icon: Icons.cancel_outlined,
            ),
          ],
        );
      },
    );
  }
}
