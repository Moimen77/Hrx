import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/employeeAttendanceItem.dart';

class Buildattendancecard extends GetView<AttendanceController> {
  const Buildattendancecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() {
        if (controller.attendanceList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "لا يوجد بيانات حضور لهذا اليوم",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          );
        }
        return SizedBox(
          height: Get.height * 0.45,
          child: ListView(
            shrinkWrap: true,
            children: List.generate(controller.attendanceList.length, (index) {
              final item = controller.attendanceList[index];
              return Employeeattendanceitem(item: item);
            }),
          ),
        );
      }),
    );
  }
}
