import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/modules/Auth/widget/AlignRightText.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/HomePage/widget/AttendanceCard.dart';
import 'package:hrx/modules/Employee/HomePage/widget/QuickAction.dart';
import 'package:hrx/modules/Employee/HomePage/widget/RecentNotificationCards.dart';
import 'package:hrx/modules/Employee/HomePage/widget/ShiftInfoCard.dart';
import 'package:hrx/modules/Employee/HomePage/widget/WelcomeRow.dart';

class HomepageForm extends GetView<Homepagecontroller> {
  const HomepageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              WelcomeRow(),
              Gap(15),
              AttendanceCard(),
              Gap(10),
              ShiftInfoCard(),
              Gap(10),
              Alignrighttext(text: 'إجرائات سريعة'),
              Gap(10),
              Quickaction(),
              Gap(15),
              Alignrighttext(text: 'أحدث الأشعارات'),
              Gap(10),
              RecentNotificationCards(),
              Gap(5),
            ],
          ),
        ),
      ),
    );
  }
}
