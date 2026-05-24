import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.spAdaptive(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10.spAdaptive(context),
              runSpacing: 8.spAdaptive(context),
              children: [
                CircleAvatar(
                  radius: 18.spAdaptive(context),
                  backgroundColor: const Color(0xffe0f2fe),
                  child: Icon(
                    Icons.person_outline,
                    color: const Color(0xff0284c7),
                    size: 20.spAdaptive(context),
                  ),
                ),
                Text(
                  permission.employeeName ?? 'غير معروف',
                  style: cairoStyle(
                    fontweight: FontWeight.bold,
                    fontSize: 16.spAdaptive(context),
                  ),
                ),
              ],
            ),
            Gap(10.spAdaptive(context)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.spAdaptive(context)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.spAdaptive(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نوع الطلب: ${permission.perm_type}',
                    style: cairoStyle(fontSize: 14.spAdaptive(context)),
                  ),
                  Gap(6.spAdaptive(context)),
                  Text(
                    'التاريخ: ${TimeHelper.formatDateToArabic(permission.perm_date)}',
                    style: cairoStyle(
                      fontSize: 14.spAdaptive(context),
                      fontcolor: Colors.grey[700],
                    ),
                  ),
                  Gap(6.spAdaptive(context)),
                  Text(
                    'البديل: ${permission.substituteEmployeeName?.isNotEmpty == true ? permission.substituteEmployeeName : 'لم يتم توفير بديل'}',
                    style: cairoStyle(fontSize: 14.spAdaptive(context)),
                  ),
                  if (permission.notes != null &&
                      permission.notes!.trim().isNotEmpty) ...[
                    Gap(6.spAdaptive(context)),
                    Text(
                      'السبب: ${permission.notes}',
                      style: cairoStyle(fontSize: 14.spAdaptive(context)),
                    ),
                  ],
                ],
              ),
            ),
            Divider(height: 20.spAdaptive(context)),
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
