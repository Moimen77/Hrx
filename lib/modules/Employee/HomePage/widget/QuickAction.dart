import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/HomePage/widget/CardAction.dart';
import 'package:hrx/modules/Employee/HomeScreenEmployee/HomeScreenController.dart';
import 'package:hrx/routes/app_pages.dart';

class Quickaction extends StatelessWidget {
  const Quickaction({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          CardAction(
            title: 'طلب أجازة',
            icon: Icons.calendar_month_outlined,
            onTap: () {
              Get.toNamed(AppRoutes.requestLeave);
            },
          ),
          Gap(15),
          CardAction(
            title: 'طلب اذن',
            icon: Icons.perm_device_info_outlined,
            onTap: () {
              Get.toNamed(AppRoutes.addpermission);
            },
          ),
          Gap(15),
          CardAction(
            title: 'طلب سلفة',
            icon: Icons.attach_money_sharp,
            onTap: () {
              Get.toNamed(AppRoutes.subminLoan);
            },
          ),
          Gap(15),
          CardAction(
            title: 'ملفي الشخصي',
            icon: Icons.person_outline_outlined,
            onTap: () {
              Get.find<Homescreencontroller>().changePage(5);
            },
          ),
        ],
      ),
    );
  }
}
