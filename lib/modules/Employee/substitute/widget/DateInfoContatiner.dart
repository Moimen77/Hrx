import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class DateInfoContatiner extends StatelessWidget {
  const DateInfoContatiner({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_month, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              leave.startDate == leave.endDate
                  ? 'يوم ${TimeHelper.formatDateToArabic(leave.startDate)}'
                  : 'من ${TimeHelper.formatDateToArabic(leave.startDate)}\nإلى ${TimeHelper.formatDateToArabic(leave.endDate)}',
              style: cairoStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
