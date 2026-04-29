import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    required this.label,
    required this.icon,
    required this.onDateSelected,
    required this.date,
    this.firstDate,
  });
  final String label;
  final IconData icon;
  final Function(DateTime) onDateSelected;
  final Rx<DateTime> date;
  final DateTime? firstDate;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade700),
              SizedBox(width: 6),
              Text(
                label,
                style: cairoStyle(fontSize: 15, fontcolor: Colors.grey[700]),
              ),
            ],
          ),
          SizedBox(height: 6),
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: date.value,
                firstDate:
                    firstDate ?? DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365 * 2)),
              );
              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(date.value),
                    style: cairoStyle(fontSize: 15, fontcolor: Colors.black87),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Appcolors.primarycolor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
