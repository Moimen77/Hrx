import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/FilterLeavesDate.dart';

class GroupFilterDate extends StatelessWidget {
  const GroupFilterDate({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 560;

        if (isNarrow) {
          return const Column(
            children: [
              FilterLeavesDate(EnFromOrTo.to),
              Gap(10),
              FilterLeavesDate(EnFromOrTo.from),
            ],
          );
        }

        return const Row(
          children: [
            Expanded(child: FilterLeavesDate(EnFromOrTo.to)),
            Gap(10),
            Expanded(child: FilterLeavesDate(EnFromOrTo.from)),
          ],
        );
      },
    );
  }
}
