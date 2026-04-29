import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Permissions/controller/Permission_Controller.dart';
import 'package:hrx/modules/Employee/Permissions/widget/PermissionCard.dart';

class ListPermissionCards extends GetView<PermissionController> {
  const ListPermissionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.fetchPermissions(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.permissions.length,
          itemBuilder: (context, index) {
            final permission = controller.permissions[index];
            return PermissionCard(permission: permission);
          },
        ),
      ),
    );
  }
}
