import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class RequestSubTitle extends StatelessWidget {
  const RequestSubTitle({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xffe0f2fe),
          child: Icon(Icons.swap_horiz, color: Color(0xff0284c7)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'طلب بديل من ${leave.employeeName}',
            style: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
