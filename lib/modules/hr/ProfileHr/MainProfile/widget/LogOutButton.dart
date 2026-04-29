import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/AlertLogOut.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';

class LogoutButton extends GetView<Hrcontroller> {
  const LogoutButton({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: OutlinedButton.icon(
        onPressed: () {
          confirmLogout(() {
            controller.logout(context);
          });
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          side: BorderSide(color: Colors.red.shade400, width: 1.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(Icons.logout, size: 20, color: Colors.red.shade600),
        label: Text(
          "تسجيل الخروج",
          style: cairoStyle(
            fontSize: 14,
            fontweight: FontWeight.bold,
            fontcolor: Colors.red.shade600,
          ),
        ),
      ),
    );
  }
}
