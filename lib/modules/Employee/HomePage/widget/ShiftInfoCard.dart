import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
            child: Padding(
              padding: EdgeInsets.all(12.spAdaptive(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.spAdaptive(context),
                    child: Icon(
                      Icons.timer_outlined,
                      color: Color(0xff1e293b),
                      size: 20.spAdaptive(context),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'دوامك الحالي',
                          style: cairoStyle(
                            fontcolor: const Color(0xff939eae),
                            fontSize: 13.spAdaptive(context),
                          ),
                        ),
                        const Gap(3),
                        controller.isCheckedIn
                            ? Text(
                                '${controller.attendance!.shift_name} (${TimeHelper.formatDurationToArabic(controller.attendance!.shift_start!)}- ${TimeHelper.formatDurationToArabic(controller.attendance!.shift_end!)})',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: cairoStyle(
                                  fontSize: 15.spAdaptive(context),
                                  fontweight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
