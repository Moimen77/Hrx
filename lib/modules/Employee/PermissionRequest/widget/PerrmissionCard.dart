import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/PermissionRequest/controller/ManagerPermissionController.dart';
import 'package:hrx/shared_widgets/RowApproveAndReject.dart';

class PerrmissionCard extends GetView<ManagerPermissionController> {
  const PerrmissionCard({super.key, required this.permission});
  final PerrmissionModel permission;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              permission.employeeName!,
              style: cairoStyle(fontweight: FontWeight.bold, fontSize: 16),
            ),
            const Gap(8),
            Text(
              'نوع الطلب: ${permission.perm_type}',
              style: cairoStyle(fontSize: 14),
            ),

            Text(
              'التاريخ: ${TimeHelper.formatDateToArabic(permission.perm_date)}',
              style: cairoStyle(fontSize: 14, fontcolor: Colors.grey[700]),
            ),
            Text(
              ' البديل: ${permission.substituteEmployeeName}',
              style: cairoStyle(fontSize: 14),
            ),
            if (permission.notes != null) ...[
              const Gap(5),
              Text(
                'السبب: ${permission.notes}',
                style: cairoStyle(fontSize: 14),
              ),
            ],
            const Divider(height: 20),
            RowApproveAndReject(
              onApprove: () async {
                await controller.actionPermission(permission, true);
              },
              onReject: () async {
                await controller.actionPermission(permission, false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
