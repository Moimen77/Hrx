import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';

class ClearFiltersButton extends GetView<AttendanceArciveController> {
  const ClearFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        controller.clearFilter();
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.spAdaptive(context)),
        side: BorderSide(color: Appcolors.primarycolor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'إلغاء الفلتر',
        style: cairoStyle(
          fontcolor: Appcolors.primarycolor,
          fontweight: FontWeight.bold,
          fontSize: 15.spAdaptive(context),
        ),
      ),
    );
  }
}
