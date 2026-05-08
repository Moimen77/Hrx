import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/ShiftsModel.dart';

class BuildshiftCard extends StatelessWidget {
  final ShiftModel shift;

  const BuildshiftCard({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.spAdaptive(context),
          height: 35.spAdaptive(context),
          color: Colors.grey[300],
        ),
        SizedBox(width: 10.spAdaptive(context)),
        Text(
          shift.name,
          style: cairoStyle(
            fontSize: 14.spAdaptive(context),
            fontweight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
