import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/LeaveCardFormperiod.dart';

class Filterperiod extends StatelessWidget {
  const Filterperiod({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 560;

        if (isNarrow) {
          return const Column(
            children: [
              LeaveCardFormPeriod(isStartDate: true),
              Gap(10),
              LeaveCardFormPeriod(isStartDate: false),
            ],
          );
        }

        return const Row(
          children: [
            Expanded(child: LeaveCardFormPeriod(isStartDate: true)),
            Gap(10),
            Expanded(child: LeaveCardFormPeriod(isStartDate: false)),
          ],
        );
      },
    );
  }
}
