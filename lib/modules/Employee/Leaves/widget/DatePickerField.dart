import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
              Icon(
                icon,
                size: 16.spAdaptive(context),
                color: Colors.grey.shade700,
              ),
              SizedBox(width: 6.spAdaptive(context)),
              Text(
                label,
                style: cairoStyle(
                  fontSize: 14.spAdaptive(context),
                  fontcolor: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.spAdaptive(context)),
          InkWell(
            borderRadius: BorderRadius.circular(16.spAdaptive(context)),
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
                borderRadius: BorderRadius.circular(16.spAdaptive(context)),
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
              ),
              child: Text(
                DateFormat('yyyy-MM-dd').format(date.value),
                style: cairoStyle(
                  fontSize: 15.spAdaptive(context),
                  fontcolor: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
