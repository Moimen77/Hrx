import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';

class LeaveCardFormPeriod extends GetView<AddLeaveController> {
  const LeaveCardFormPeriod({super.key, required this.isStartDate});
  final bool isStartDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              isStartDate ? 'من تاريخ' : 'إلي تاريخ',
              style: cairoStyle(
                fontSize: 14.spAdaptive(context),
                fontweight: FontWeight.w600,
                fontcolor: const Color(0xff484b50),
              ),
            ),
          ),
        ),
        const Gap(5),
        GestureDetector(
          onTap: () => controller.pickDate(context, isStartDate),
          child: Filtercard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    return Text(
                      isStartDate
                          ? controller.startDate.value == null
                              ? 'اختر تاريخ البدء'
                              : formatDayMonth(controller.startDate.value!)
                          : controller.endDate.value == null
                              ? 'اختر تاريخ النهاية'
                              : formatDayMonth(controller.endDate.value!),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: cairoStyle(
                        fontSize: 13.spAdaptive(context),
                        fontweight: FontWeight.w600,
                        fontcolor: Colors.grey.shade800,
                      ),
                    );
                  }),
                ),
                Icon(
                  Icons.calendar_month,
                  size: 20.spAdaptive(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
