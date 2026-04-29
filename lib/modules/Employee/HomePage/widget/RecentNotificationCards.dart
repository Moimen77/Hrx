import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/GetActivityData.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/HomePage/widget/NotificationCard.dart';

class RecentNotificationCards extends GetView<Homepagecontroller> {
  const RecentNotificationCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.activities.length,
        itemBuilder: (context, index) {
          final data = getActivityData(
            controller.activities[index],
            isEmployee: true,
          );
          return NotificationCard(
            title: data['title'],
            subtitle: data['description'],
            icon: data['icon'],
          );
        },
      ),
    );
  }
}
