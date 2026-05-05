import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/routes/app_pages.dart';

class AddEmployeeButton extends StatelessWidget {
  const AddEmployeeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.spAdaptive(context),
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed(AppRoutes.addEmployee),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.green.shade600,
        ),
        icon: Icon(Icons.person_add_alt_1, size: 20.spAdaptive(context)),
        label: Text(
          "إضافة حساب موظف",
          style: cairoStyle(
            fontSize: 15.spAdaptive(context),
            fontweight: FontWeight.bold,
            fontcolor: Colors.white,
          ),
        ),
      ),
    );
  }
}
