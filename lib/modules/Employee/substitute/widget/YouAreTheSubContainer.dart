import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
        size: 18.spAdaptive(context),
      ),
      label: Text(
        isSub
            ? 'أنت البديل لهذا الطلب'
            : 'البديل: ${leave.substituteEmployeeName ?? 'غير محدد'}',
        style: cairoStyle(
          fontSize: 13.spAdaptive(context),
          fontcolor: Colors.white,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.spAdaptive(context),
        vertical: 6.spAdaptive(context),
      ),
      backgroundColor: isSub ? Colors.blue : Colors.blue.shade900,
    );
  }
}
