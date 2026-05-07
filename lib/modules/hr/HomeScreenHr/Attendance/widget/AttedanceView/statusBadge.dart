// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/employeeDayModel.dart';

class Statusbadge extends StatelessWidget {
  Statusbadge({super.key, required this.attendance});
  final EmployeeDayModel attendance;
  Color? color;
  String? text;

  @override
  Widget build(BuildContext context) {
    switch (attendance.status) {
      case "present":
        color = Colors.green;
        text = "حاضر";
        break;
      case "late":
        color = Colors.orange;
        text = "متأخر";
        break;
      case "friday":
        color = Colors.purple;
        text = "جمعة";
        break;
      case "thursday":
        color = Colors.purple;
        text = "خميس";
        break;
      case "official_holiday":
        color = Colors.red;
        text = "اجازة رسمية";
        break;
      case "leave":
        color =
            (attendance.hr_leave_approve == 'مرفوضة' &&
                attendance.checkIn == null)
            ? Colors.red
            : Colors.blue;
        text = (attendance.hr_leave_approve == 'مرفوضة')
            ? (attendance.checkIn != null)
                  ? 'حضور'
                  : 'غياب'
            : "أجازة";
        break;
      case "absent":
        color = Colors.red;
        text = "غائب";
        break;
      default:
        color = Colors.blue;
        text = attendance.status;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.spAdaptive(context),
          height: 10.spAdaptive(context),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          text ?? '',
          style: cairoStyle(
            fontcolor: color,
            fontweight: FontWeight.bold,
            fontSize: 12.spAdaptive(context),
          ),
        ),
      ],
    );
  }
}
