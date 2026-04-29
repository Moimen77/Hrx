import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/Permissions/widget/InfoPermissionRow.dart';
import 'package:hrx/modules/Employee/Permissions/widget/TitlePermissionCard.dart';

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitlePermissionCard(permission: permission),
            const Divider(height: 24),
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
            if (permission.notes != null && permission.notes!.isNotEmpty)
              InfoPermissionRow(
                icon: Icons.notes,
                label: 'ملاحظات',
                value: permission.notes!,
              ),
          ],
        ),
      ),
    );
  }
}
