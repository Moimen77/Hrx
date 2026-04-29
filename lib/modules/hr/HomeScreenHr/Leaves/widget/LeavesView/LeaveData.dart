import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';

class Leavedata extends StatelessWidget {
  const Leavedata({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          leave.employeeName ?? "",
          style: cairoStyle(
            fontweight: FontWeight.bold,
            fontSize: 15.spAdaptive(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(5),
        Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 14.spAdaptive(context),
              color: Colors.grey,
            ),
            const Gap(5),
            Expanded(
              child: Text(
                leave.startDate == leave.endDate
                    ? TimeHelper.formatDateToArabic(leave.startDate)
                    : '${TimeHelper.formatDateToArabic(leave.startDate)} \n ${TimeHelper.formatDateToArabic(leave.endDate)}',
                style: cairoStyle(
                  fontSize: 12.spAdaptive(context),
                  fontcolor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 14.spAdaptive(context),
              color: Colors.grey,
            ),
            const Gap(5),
            Expanded(
              child: Text(
                'اجازة ${leave.leaveType}',
                style: cairoStyle(
                  fontSize: 12.spAdaptive(context),
                  fontcolor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        if (leave.notes != null && leave.notes!.isNotEmpty) ...[
          const Gap(5),
          Text(
            'ملاحظات: ${leave.notes}',
            style: cairoStyle(
              fontSize: 12.spAdaptive(context),
              fontcolor: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const Gap(5),
        Wrap(
          spacing: 10,
          runSpacing: 6,
          children: [
            _buildStatusItem(
              context,
              "المدير",
              leave.managerApproved,
              Icons.admin_panel_settings,
            ),
            _buildInfoItem(
              context,
              "البديل",
              leave.substituteEmployeeName ?? 'لا يوجد',
              Icons.person,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusItem(
    BuildContext context,
    String label,
    bool? status,
    IconData icon,
  ) {
    Color color = status == true
        ? Colors.green
        : status == false
        ? Colors.red
        : Colors.orange;
    String text = status == true
        ? "موافق"
        : status == false
        ? "مرفوض"
        : "انتظار";
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.spAdaptive(context), color: Colors.grey),
        const Gap(4),
        Text(
          "$label: ",
          style: cairoStyle(
            fontSize: 12.spAdaptive(context),
            fontcolor: Colors.grey,
          ),
        ),
        Text(
          text,
          style: cairoStyle(fontSize: 12.spAdaptive(context), fontcolor: color),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13.spAdaptive(context), color: Colors.grey),
        const Gap(3),
        Text(
          "$label: ",
          style: cairoStyle(
            fontSize: 11.spAdaptive(context),
            fontcolor: Colors.grey,
          ),
        ),
        Text(
          value,
          style: cairoStyle(
            fontSize: 12.spAdaptive(context),
            fontcolor: Colors.black,
          ),
        ),
      ],
    );
  }
}
