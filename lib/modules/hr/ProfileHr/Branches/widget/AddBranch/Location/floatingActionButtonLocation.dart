// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/AddBranchLocationController.dart';
import 'package:hrx/routes/app_pages.dart';

Widget FloatingActionButtonLocation() {
  final controller = Get.find<AddBranchLocationController>();
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: "current_location",
          backgroundColor: Appcolors.primarycolor,
          onPressed: () => controller.getCurrentLocation(),
          child: const Icon(Icons.my_location, color: Colors.white),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.primarycolor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.toNamed(
                AppRoutes.addBranchDetails,
                arguments: {
                  'lat': controller.currentCenter.value.latitude,
                  'lng': controller.currentCenter.value.longitude,
                },
              );
            },
            child: Text(
              "المتابعة",
              style: cairoStyle(
                fontcolor: Colors.white,
                fontSize: 16,
                fontweight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
