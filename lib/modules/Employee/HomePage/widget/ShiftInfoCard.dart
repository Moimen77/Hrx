import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';

class ShiftInfoCard extends GetView<Homepagecontroller> {
  const ShiftInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return !controller.isCheckedIn
        ? const SizedBox.shrink()
        : Card(
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(7),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.timer_outlined, color: Color(0xff1e293b)),
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'دوامك الحالي',
                          style: cairoStyle(
                            fontcolor: const Color(0xff939eae),
                            fontSize: 13,
                          ),
                        ),
                        const Gap(3),
                        controller.isCheckedIn
                            ? Text(
                                '${controller.attendance!.shift_name} (${TimeHelper.formatDurationToArabic(controller.attendance!.shift_start!)}- ${TimeHelper.formatDurationToArabic(controller.attendance!.shift_end!)})',
                                style: cairoStyle(
                                  fontSize: 15,
                                  fontweight: FontWeight.w600,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
