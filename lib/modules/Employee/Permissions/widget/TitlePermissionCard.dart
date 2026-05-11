import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/Permissions/controller/Permission_Controller.dart';
import 'package:hrx/modules/Employee/Permissions/widget/StatusPermissionBadge.dart';

class TitlePermissionCard extends GetView<PermissionController> {
  const TitlePermissionCard({super.key, required this.permission});
  final PerrmissionModel permission;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12.spAdaptive(context),
      runSpacing: 8.spAdaptive(context),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 15.spAdaptive(context),
              child: Icon(
                Icons.access_alarms,
                size: 18.spAdaptive(context),
              ),
            ),
            SizedBox(width: 6.spAdaptive(context)),
            Text(
              permission.perm_type,
              style: cairoStyle(
                fontSize: 16.spAdaptive(context),
                fontweight: FontWeight.bold,
              ),
            ),
          ],
        ),
        controller.ismanager
            ? const SizedBox.shrink()
            : StatusPermissionBadge(status: permission.managerApproved),
      ],
    );
  }
}
