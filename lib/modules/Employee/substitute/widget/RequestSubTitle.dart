import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class RequestSubTitle extends StatelessWidget {
  const RequestSubTitle({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.spAdaptive(context),
          backgroundColor: Color(0xffe0f2fe),
          child: Icon(
            Icons.swap_horiz,
            color: Color(0xff0284c7),
            size: 18.spAdaptive(context),
          ),
        ),
        SizedBox(width: 10.spAdaptive(context)),
        Expanded(
          child: Text(
            'طلب بديل من ${leave.employeeName}',
            style: cairoStyle(
              fontSize: 16.spAdaptive(context),
              fontweight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
