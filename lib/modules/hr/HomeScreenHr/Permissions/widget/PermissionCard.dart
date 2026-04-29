import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/controller/PermissionController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/widget/InfoPermissionRow.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/widget/TitlePermissionCard.dart';
import 'package:hrx/shared_widgets/RowApproveAndReject.dart';

class PermissionCard extends StatelessWidget {
  const PermissionCard({super.key, required this.permission});
  final PerrmissionModel permission;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitlePermissionCard(permission: permission),
            const Divider(height: 24),
            InfoPermissionRow(
              icon: Icons.person_outline,
              label: 'الموظف',
              value: permission.employeeName!,
            ),
            InfoPermissionRow(
              icon: Icons.calendar_month_outlined,
              label: 'التاريخ',
              value: TimeHelper.formatDateToArabic(permission.perm_date),
            ),
            InfoPermissionRow(
              icon: Icons.person_outline,
              label: 'البديل',
              value: permission.substituteEmployeeName!,
            ),
            InfoPermissionRow(
              icon: Icons.description_rounded,
              label: 'موافقة المدير',
              value: permission.managerApproved == null
                  ? 'ليس بعد'
                  : permission.managerApproved == true
                      ? 'موافقة'
                      : 'رفض',
            ),
            if (permission.notes != null && permission.notes!.isNotEmpty)
              InfoPermissionRow(
                icon: Icons.notes,
                label: 'ملاحظات',
                value: permission.notes!,
              ),
            if (permission.hr_approve == null)
              Column(
                children: [
                  Divider(),
                  RowApproveAndReject(
                    onApprove: () => Get.find<PermissionController>()
                        .updateStatus(permission, true),
                    onReject: () => Get.find<PermissionController>()
                        .updateStatus(permission, false),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
