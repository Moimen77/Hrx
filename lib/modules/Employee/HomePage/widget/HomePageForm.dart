import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
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
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return SafeArea(
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 1280
                  : isTablet
                  ? 980
                  : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 24 : 12),
              child: isDesktop ? _desktopLayout() : _mobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return Column(
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
    );
  }

  Widget _desktopLayout() {
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height,
      child: Column(
        children: [
          WelcomeRow(),
          Gap(18),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AttendanceCard(),
                        Gap(12),
                        ShiftInfoCard(),
                        Gap(12),
                        Alignrighttext(text: 'إجرائات سريعة'),
                        Gap(10),
                        Quickaction(),
                      ],
                    ),
                  ),
                ),
                Gap(24),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Alignrighttext(text: 'أحدث الأشعارات'),
                      Gap(10),
                      RecentNotificationCards(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
