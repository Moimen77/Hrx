import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/Activity/GetActivityData.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/HomePageHr/view/HomePageView.dart';
import 'package:hrx/modules/hr/HomePageHr/widget/StatCard.dart';
import 'package:hrx/shared_widgets/CustomRefresh.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class HrHomeScreen extends GetView<HomeController> {
  const HrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Loadingcircular();
      }

      if (controller.hasError.value) {
        return NoInternetWidget(onPressed: controller.fetchHomeData);
      }

      return _ResponsiveHome(controller: controller);
    });
  }
}

class _ResponsiveHome extends StatelessWidget {
  final HomeController controller;

  const _ResponsiveHome({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _WebHome(controller: controller);
    } else if (Responsive.isTablet(context)) {
      return _TabletHome(controller: controller);
    } else {
      return _MobileHome(controller: controller);
    }
  }
}

class _MobileHome extends StatelessWidget {
  final HomeController controller;

  const _MobileHome({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomRefreshWrapper(
        onRefresh: controller.fetchHomeData,
        child: Column(
          children: [
            const HomeHeader(),

            const SizedBox(height: 16),

            _StatsGrid(controller: controller, crossAxisCount: 2),

            const SizedBox(height: 20),

            _ActivitiesSection(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _TabletHome extends StatelessWidget {
  final HomeController controller;

  const _TabletHome({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomRefreshWrapper(
        onRefresh: controller.fetchHomeData,
        child: Column(
          children: [
            const HomeHeader(),

            const SizedBox(height: 20),

            _StatsGrid(controller: controller, crossAxisCount: 2),

            const SizedBox(height: 25),

            _ActivitiesSection(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _WebHome extends StatelessWidget {
  final HomeController controller;

  const _WebHome({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const HomeHeader(),

                    _StatsGrid(controller: controller, crossAxisCount: 2),

                    const SizedBox(height: 10),

                    _ActivitiesSection(controller: controller),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final HomeController controller;
  final int crossAxisCount;

  const _StatsGrid({required this.controller, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final isdesktop = Responsive.isDesktop(context);
    final istablet = Responsive.isTablet(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: isdesktop
              ? 175.h
              : istablet
              ? 140.h
              : 150.h,
        ),
        itemBuilder: (context, index) {
          return _buildCard(index);
        },
      ),
    );
  }

  Widget _buildCard(int index) {
    final stats = controller.statistics.value;

    switch (index) {
      case 0:
        return StatCard(
          title: "طلبات الأذونات",
          value: "${stats?.pendingPermissions ?? 0}",
          icon: Icons.access_time_filled_rounded,
          color: Colors.orange,
        );
      case 1:
        return StatCard(
          title: "طلبات الأجازة",
          value: "${stats?.pendingLeaves ?? 0}",
          icon: Icons.flight_takeoff_rounded,
          color: Colors.blue,
        );
      case 2:
        return StatCard(
          title: "رواتب الشهر",
          value: "${stats?.totalSalaries ?? 0} ج.م",
          icon: Icons.monetization_on_rounded,
          color: Colors.green,
        );
      case 3:
        return StatCard(
          title: "إجمالي الموظفين",
          value: "${stats?.totalEmployees ?? 0}",
          icon: Icons.groups_rounded,
          color: const Color(0xff197fe6),
        );
      default:
        return const SizedBox();
    }
  }
}

class _ActivitiesSection extends StatelessWidget {
  final HomeController controller;

  const _ActivitiesSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final activities = controller.statistics.value?.recentActivities ?? [];

    if (activities.isEmpty) {
      return const Center(child: Text("لا توجد أحداث حديثة"));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final data = getActivityData(activities[index], isEmployee: false);
          final isdesktop = Responsive.isDesktop(context);

          return Container(
            margin: EdgeInsets.only(bottom: isdesktop ? 0.h : 10.h),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              children: [
                Icon(data['icon'], color: const Color(0xff197fe6)),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: cairoStyle(fontSize: !isdesktop ? 15.sp : 10.sp),
                      ),
                      Text(
                        data['description'],
                        style: cairoStyle(
                          fontcolor: Colors.grey,
                          fontSize: !isdesktop ? 12.sp : 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
