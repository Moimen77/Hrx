import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class YouAreTheSubContainer extends StatelessWidget {
  const YouAreTheSubContainer({
    super.key,
    required this.isSub,
    required this.leave,
  });
  final bool isSub;
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        isSub ? Icons.check_circle : Icons.person,
        color: Colors.white,
      ),
      label: Text(
        isSub
            ? 'أنت البديل لهذا الطلب'
            : 'البديل: ${leave.substituteEmployeeName ?? 'غير محدد'}',
        style: cairoStyle(fontSize: 13, fontcolor: Colors.white),
      ),
      backgroundColor: isSub ? Colors.blue : Colors.blue.shade900,
    );
  }
}
