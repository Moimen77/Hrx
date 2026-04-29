import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/MangementCard.dart';
import 'package:hrx/routes/app_pages.dart';

class MangementsCards extends StatelessWidget {
  const MangementsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MangementCard(
          title: 'إدارة الفروع',
          subtitle: 'إدارة، إضافة، حذف الفروع',
          icon: Icons.storefront_rounded,
          onTap: () => Get.toNamed(AppRoutes.branches),
        ),
        MangementCard(
          title: 'إدارة الأقسام',
          subtitle: 'إدارة و إضافة الأقسام',
          icon: Icons.category_rounded,
          onTap: () => Get.toNamed(AppRoutes.departments),
        ),
        MangementCard(
          title: 'إدارة الشيفتات',
          subtitle: 'الشيفت الصيفي والشتوي',
          icon: Icons.access_time_filled,
          onTap: () => Get.toNamed(AppRoutes.shifts),
        ),
        MangementCard(
          title: 'سجل الجزائات',
          subtitle: 'عرض و تعديل الجزائات',
          icon: Icons.attach_money_outlined,
          onTap: () => Get.toNamed(AppRoutes.rival),
        ),
        MangementCard(
          title: 'سجل المكافئات',
          subtitle: 'عرض و تعديل المكافئات',
          icon: Icons.attach_money_outlined,
          onTap: () => Get.toNamed(AppRoutes.bonuses),
        ),
      ],
    );
  }
}
