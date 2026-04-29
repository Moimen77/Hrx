import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/Permissions/controller/Permission_Controller.dart';
import 'package:hrx/modules/Employee/Permissions/widget/StatusPermissionBadge.dart';

class TitlePermissionCard extends GetView<PermissionController> {
  const TitlePermissionCard({super.key, required this.permission});
  final PerrmissionModel permission;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              child: Icon(Icons.access_alarms, size: 20),
            ),
            SizedBox(width: 5),
            Text(
              permission.perm_type,
              style: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
            ),
          ],
        ),
        controller.ismanager
            ? SizedBox.shrink()
            : StatusPermissionBadge(status: permission.managerApproved),
      ],
    );
  }
}
