import 'package:flutter/material.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class Leavedata extends StatelessWidget {
  const Leavedata({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    final subTextStyle = cairoStyle(
      fontcolor: const Color(0xff64748b),
      fontSize: 12.spAdaptive(context),
      fontweight: FontWeight.w500,
    );
    final iconColor = Colors.grey.shade400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اجازة ${leave.leaveType}',
          style: cairoStyle(
            fontSize: 15.spAdaptive(context),
            fontweight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.spAdaptive(context)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 16.spAdaptive(context),
              color: iconColor,
            ),
            SizedBox(width: 6.spAdaptive(context)),
            Expanded(
              child: Text(
                leave.startDate == leave.endDate
                    ? 'يوم ${TimeHelper.formatDateToArabic(leave.startDate)}'
                    : '${TimeHelper.formatDateToArabic(leave.startDate)}\n${TimeHelper.formatDateToArabic(leave.endDate)}',
                style: subTextStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.spAdaptive(context)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.person_outline,
              size: 16.spAdaptive(context),
              color: iconColor,
            ),
            SizedBox(width: 6.spAdaptive(context)),
            Expanded(
              child: Text(
                leave.substituteEmployeeName != null &&
                        leave.substituteEmployeeName!.isNotEmpty
                    ? 'البديل: ${leave.substituteEmployeeName}'
                    : 'لم يتم توفير بديل',
                style: subTextStyle,
              ),
            ),
          ],
        ),
        if (leave.notes != null && leave.notes!.isNotEmpty) ...[
          SizedBox(height: 4.spAdaptive(context)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.description_outlined,
                size: 16.spAdaptive(context),
                color: iconColor,
              ),
              SizedBox(width: 6.spAdaptive(context)),
              Expanded(
                child: Text(
                  'ملاحظات: ${leave.notes}',
                  style: subTextStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
