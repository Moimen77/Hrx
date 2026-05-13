import 'package:flutter/material.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class DateInfoContatiner extends StatelessWidget {
  const DateInfoContatiner({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.spAdaptive(context)),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.spAdaptive(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_month,
            color: Colors.grey,
            size: 20.spAdaptive(context),
          ),
          SizedBox(width: 8.spAdaptive(context)),
          Expanded(
            child: Text(
              leave.startDate == leave.endDate
                  ? 'يوم ${TimeHelper.formatDateToArabic(leave.startDate)}'
                  : 'من ${TimeHelper.formatDateToArabic(leave.startDate)}\nإلى ${TimeHelper.formatDateToArabic(leave.endDate)}',
              style: cairoStyle(fontSize: 14.spAdaptive(context)),
            ),
          ),
        ],
      ),
    );
  }
}
