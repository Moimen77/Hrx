import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as dart_ui;
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/ActionLeaveButtons.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/LeaveBadge.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/LeaveData.dart';

class Leavecard extends GetView<LeaveController> {
  const Leavecard({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Filtercard(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 520;

              return Column(
                children: [
                  if (isCompact) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24.spAdaptive(context),
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: leave.profileImage != null
                              ? NetworkImage(leave.profileImage!)
                              : null,
                          child: leave.profileImage != null
                              ? null
                              : Icon(Icons.person, color: Colors.grey),
                        ),
                        const Gap(10),
                        Expanded(child: Leavedata(leave: leave)),
                      ],
                    ),
                    const Gap(12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: LeaveStatusBadge(status: leave.status),
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 21.spAdaptive(context),
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: leave.profileImage != null
                              ? NetworkImage(leave.profileImage!)
                              : null,
                          child: leave.profileImage != null
                              ? null
                              : Icon(Icons.person, color: Colors.grey),
                        ),
                        const Gap(5),
                        Expanded(child: Leavedata(leave: leave)),
                        const Gap(5),
                        LeaveStatusBadge(status: leave.status),
                      ],
                    ),
                  ],
                  leave.status == 'معلقة'
                      ? Actionleavebuttons(leave: leave)
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
