import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/HomePage/widget/TimeItem.dart';

class AttendanceInfo extends GetView<Homepagecontroller> {
  const AttendanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final att = controller.attendance;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 290;

        final checkInValue = att?.checkIn != null
            ? formatTimeToArabic(
                att!.checkIn!.subtract(const Duration(hours: 2)).toString(),
              )
            : '---';

        final checkOutValue = att?.checkOut != null
            ? formatTimeToArabic(
                att!.checkOut!.subtract(const Duration(hours: 2)).toString(),
              )
            : '---';

        final shiftValue = (att?.shift_start != null && att?.shift_end != null)
            ? TimeHelper.hoursBetween(
                att!.shift_start.toString(),
                att.shift_end.toString(),
              ).toString()
            : '---';

        return isWide
            ? Row(
                children: [
                  Expanded(
                    child: TimeItem(title: 'وقت الحضور', value: checkInValue),
                  ),
                  Container(
                    width: 1,
                    height: 45.spAdaptive(context),
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: TimeItem(
                      title: 'وقت الانصراف',
                      value: checkOutValue,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 45.spAdaptive(context),
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: TimeItem(title: 'إجمالي الشيفت', value: shiftValue),
                  ),
                ],
              )
            : Column(
                children: [
                  TimeItem(title: 'وقت الحضور', value: checkInValue),
                  const Divider(),
                  TimeItem(title: 'وقت الانصراف', value: checkOutValue),
                  const Divider(),
                  TimeItem(title: 'إجمالي الشيفت', value: shiftValue),
                ],
              );
      },
    );
  }
}
