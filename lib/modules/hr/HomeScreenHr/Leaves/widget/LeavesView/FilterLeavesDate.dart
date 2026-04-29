import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart' show GetView, Obx;
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';

class FilterLeavesDate extends GetView<LeaveController> {
  const FilterLeavesDate(this.fromOrTo, {super.key});
  final EnFromOrTo fromOrTo;

  @override
  Widget build(BuildContext context) {
    bool isfrom = fromOrTo == EnFromOrTo.from;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              !isfrom ? 'الى تاريخ' : 'من تاريخ',
              style: cairoStyle(
                fontSize: 12.spAdaptive(context),
                fontweight: FontWeight.w600,
                fontcolor: const Color(0xff484b50),
              ),
            ),
          ),
        ),
        const Gap(5),
        GestureDetector(
          onTap: () => controller.pickDate(context, fromOrTo),
          child: Filtercard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    bool isfrom = fromOrTo == EnFromOrTo.from;
                    String displayDate = isfrom
                        ? "${controller.DateFrom.value.year}-${controller.DateFrom.value.month}-${controller.DateFrom.value.day}"
                        : "${controller.DateTo.value.year}-${controller.DateTo.value.month}-${controller.DateTo.value.day}";
                    return Text(
                      displayDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: cairoStyle(
                        fontSize: 12.spAdaptive(context),
                        fontweight: FontWeight.w700,
                        fontcolor: Colors.grey.shade800,
                      ),
                    );
                  }),
                ),
                Icon(Icons.calendar_month, size: 18.spAdaptive(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
