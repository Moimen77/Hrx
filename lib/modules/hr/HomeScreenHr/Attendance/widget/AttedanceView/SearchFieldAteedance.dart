import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';

class Searchfieldateedance extends GetView<AttendanceController> {
  const Searchfieldateedance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF7F9FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black45),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(.05),
          ),
        ],
      ),
      child: TextField(
        controller: controller.EmployeeName,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: ".......ابحث عن موظف",
          hintStyle: cairoStyle(
            fontSize: 14.spAdaptive(context),
            fontcolor: Colors.grey,
          ),
          prefixIcon: InkWell(
            onTap: () {
              controller.changeSearch(controller.EmployeeName.text);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xff197fe6).withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.search,
                color: Color(0xff197fe6),
                size: 20.spAdaptive(context),
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
