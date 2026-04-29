import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/statusBadge.dart';

class DateAndAtatus extends StatelessWidget {
  const DateAndAtatus({super.key, required this.item});
  final EmployeeDayModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formatDayMonth(item.date),
          style: cairoStyle(fontweight: FontWeight.bold, fontSize: 16),
        ),
        Statusbadge(attendance: item),
      ],
    );
  }
}
