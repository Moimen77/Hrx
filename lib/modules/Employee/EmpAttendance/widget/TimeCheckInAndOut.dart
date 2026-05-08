import 'package:flutter/material.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/employeeDayModel.dart';

class TimeCheckInAndOut extends StatelessWidget {
  const TimeCheckInAndOut({super.key, required this.item});
  final EmployeeDayModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildTimeInfo(context, true), _buildTimeInfo(context, false)],
    );
  }

  Widget _buildTimeInfo(BuildContext context, bool isCheckIn) {
    final icon = isCheckIn ? Icons.login : Icons.logout;
    final color = isCheckIn ? Colors.green : Colors.red;
    final label = isCheckIn ? 'دخول' : 'خروج';
    final value = isCheckIn
        ? (item.checkIn != null
              ? TimeHelper.formatToArabicTime(item.checkIn!)
              : '--')
        : (item.checkOut != null
              ? TimeHelper.formatToArabicTime(item.checkOut!)
              : '--');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20.spAdaptive(context)),
        SizedBox(width: 8.spAdaptive(context)),
        Text(
          '$label: $value',
          style: cairoStyle(fontSize: 14.spAdaptive(context)),
        ),
      ],
    );
  }
}
