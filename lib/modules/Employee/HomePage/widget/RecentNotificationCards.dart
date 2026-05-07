import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/GetActivityData.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/HomePage/widget/NotificationCard.dart';

class RecentNotificationCards extends GetView<Homepagecontroller> {
  const RecentNotificationCards({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.activities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(controller.activities.length, (index) {
            final data = getActivityData(
              controller.activities[index],
              isEmployee: true,
            );
            return NotificationCard(
              title: data['title'],
              subtitle: data['description'],
              icon: data['icon'],
            );
          }),
        ),
      ),
    );
  }
}
