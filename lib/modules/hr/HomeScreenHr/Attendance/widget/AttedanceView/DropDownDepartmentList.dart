import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';

class Dropdowndepartmentlist extends GetView<AttendanceController> {
  const Dropdowndepartmentlist({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: Obx(
        () => Filtercard(
          child: DropdownButton<String>(
            value: controller.selectedDepartment.value,
            isExpanded: true,
            underline: const SizedBox(),
            items: controller.departments.map((d) {
              return DropdownMenuItem(
                value: d.name,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    d.name,
                    style: cairoStyle(
                      fontSize: 14,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (v) => controller.changeDepartment(v!),
          ),
        ),
      ),
    );
  }
}
