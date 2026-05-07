import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/Employee/HomePage/widget/CardAction.dart';
import 'package:hrx/modules/Employee/HomeScreenEmployee/HomeScreenController.dart';
import 'package:hrx/routes/app_pages.dart';

class Quickaction extends StatelessWidget {
  const Quickaction({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      CardAction(
        title: 'طلب أجازة',
        icon: Icons.calendar_month_outlined,
        onTap: () {
          Get.toNamed(AppRoutes.requestLeave);
        },
      ),
      CardAction(
        title: 'طلب اذن',
        icon: Icons.perm_device_info_outlined,
        onTap: () {
          Get.toNamed(AppRoutes.addpermission);
        },
      ),
      CardAction(
        title: 'طلب سلفة',
        icon: Icons.attach_money_sharp,
        onTap: () {
          Get.toNamed(AppRoutes.subminLoan);
        },
      ),
      CardAction(
        title: 'ملفي الشخصي',
        icon: Icons.person_outline_outlined,
        onTap: () {
          Get.find<Homescreencontroller>().changePage(5);
        },
      ),
    ];

    if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
      return Wrap(spacing: 16, runSpacing: 16, children: actions);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: actions
            .map(
              (action) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: action,
              ),
            )
            .toList(),
      ),
    );
  }
}
