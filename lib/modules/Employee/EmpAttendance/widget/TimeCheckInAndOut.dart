import 'package:flutter/material.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/employeeDayModel.dart';

class TimeCheckInAndOut extends StatelessWidget {
  const TimeCheckInAndOut({super.key, required this.item});
  final EmployeeDayModel item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.login, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(
                  "دخول: ${item.checkIn != null ? TimeHelper.formatToArabicTime(item.checkIn!) : '--'}",
                  style: cairoStyle(fontSize: 14),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                const Icon(Icons.logout, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Text(
                  "خروج: ${item.checkOut != null ? TimeHelper.formatToArabicTime(item.checkOut!) : '--'}",
                  style: cairoStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
