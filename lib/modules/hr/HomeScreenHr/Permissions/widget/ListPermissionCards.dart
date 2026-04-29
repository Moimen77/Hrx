import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/controller/PermissionController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/widget/PermissionCard.dart';

class ListPermissionCards extends GetView<PermissionController> {
  const ListPermissionCards({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.isDesktop(context) ? 960.0 : 820.0;
    final permissions = controller.permissions;

    return RefreshIndicator(
      onRefresh: () => controller.fetchPermissions(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: permissions.length,
          itemBuilder: (context, index) {
            final permission = permissions[index];
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: PermissionCard(permission: permission),
              ),
            );
          },
        ),
      ),
    );
  }
}
