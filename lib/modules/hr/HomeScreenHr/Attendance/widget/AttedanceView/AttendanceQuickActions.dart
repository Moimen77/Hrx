import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/class/AttendanceMode.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/Binding/ManualCheckinBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/view/manual_checkin_screen.dart';

class AttendanceQuickActions extends StatelessWidget {
  const AttendanceQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _quickActionCard(
            context: context,
            title: "تسجيل حضور يدوي",
            icon: Icons.login_rounded,
            color: Colors.amber.shade600,
            onTap: () {
              Get.to(
                () => ManualAttendanceScreen(mode: Attendancemode.checkIn),
                binding: Manualcheckinbinding(),
              );
            },
          ),
          _quickActionCard(
            context: context,
            title: "تسجيل خروج يدوي",
            icon: Icons.logout_rounded,
            color: Colors.amber.shade400,
            onTap: () {
              Get.to(
                () => ManualAttendanceScreen(mode: Attendancemode.checkOut),
                binding: Manualcheckinbinding(),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _quickActionCard({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.all(14.spAdaptive(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25.spAdaptive(context),
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 23.spAdaptive(context)),
          ),
          SizedBox(height: 5.spAdaptive(context)),
          Text(
            title,
            style: cairoStyle(
              fontSize: 12.spAdaptive(context),
              fontweight: FontWeight.bold,
              fontcolor: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
