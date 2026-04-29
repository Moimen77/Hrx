import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TodayAttendanceStatus(),
            const Gap(15),
            AttendanceInfo(),
            const Gap(20),
            RegisterAttendanceButton(),
          ],
        ),
      ),
    );
  }
}
