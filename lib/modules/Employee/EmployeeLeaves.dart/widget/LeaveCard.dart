import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as dart_ui;
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/controller/employee_leaves_controller.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveBadge.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveData.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';

class Leavecard extends GetView<EmployeeLeavesController> {
  const Leavecard({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    final isWide =
        Responsive.isDesktop(context) || Responsive.isTablet(context);

    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.spAdaptive(context)),
        child: Filtercard(
          child: Column(
            children: [
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Leavedata(leave: leave)),
                        SizedBox(width: 12.spAdaptive(context)),
                        LeaveStatusBadge(status: leave.status),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: LeaveStatusBadge(status: leave.status),
                        ),
                        SizedBox(height: 10.spAdaptive(context)),
                        Leavedata(leave: leave),
                      ],
                    ),
              if (leave.hrDecision != null &&
                  leave.hrDecision!.trim().isNotEmpty) ...[
                Gap(10.spAdaptive(context)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.spAdaptive(context)),
                  decoration: BoxDecoration(
                    color: const Color(0xfff8fafc),
                    borderRadius: BorderRadius.circular(12.spAdaptive(context)),
                  ),
                  child: Text(
                    'الرد: ${leave.hrDecision}',
                    style: TextStyle(
                      fontSize: 12.spAdaptive(context),
                      color: const Color(0xff475569),
                      fontFamily: 'cairo',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
