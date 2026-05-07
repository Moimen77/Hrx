import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/HomePage/widget/AttendanceInfo.dart';
import 'package:hrx/modules/Employee/HomePage/widget/RegisterAttendanceButton.dart';
import 'package:hrx/modules/Employee/HomePage/widget/TodayAttendanceStatus.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(14.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TodayAttendanceStatus(),
            const Gap(15),
            const AttendanceInfo(),
            const Gap(20),
            const RegisterAttendanceButton(),
          ],
        ),
      ),
    );
  }
}
