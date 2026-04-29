// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';

class Datetimepickerfield extends StatelessWidget {
  Datetimepickerfield(this.widget, {super.key, this.onTap, required this.text});
  final double widget;
  void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget,
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Filtercard(
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: cairoStyle(
                      fontSize: 14.spAdaptive(context),
                      fontweight: FontWeight.w700,
                      fontcolor: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),

              Icon(Icons.calendar_month, size: 20.spAdaptive(context)),
            ],
          ),
        ),
      ),
    );
  }
}
