import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/MangementCard.dart';
import 'package:hrx/routes/app_pages.dart';

class MangementsCards extends StatelessWidget {
  const MangementsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
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
    ];

    if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: Responsive.isDesktop(context) ? 2.5 : 3.4,
        ),
        itemBuilder: (context, index) => items[index],
      );
    }

    return Column(
      children: items,
    );
  }
}
