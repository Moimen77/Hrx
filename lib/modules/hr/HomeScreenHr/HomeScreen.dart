import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/function/AlertExitApp.dart';
import 'package:hrx/modules/hr/HomeScreenHr/HomeScreenController.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';
import 'package:hrx/shared_widgets/sideBar/side_menue_Bar.dart';

class Homescreen extends GetView<Homescreencontroller> {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return; // لو خرج خلاص
        showExitDialog(context);
      },
      child: Builder(
        builder: (context) {
          if (Responsive.isDesktop(context)) return _webLayout();
          if (Responsive.isTablet(context)) return _tabletLayout();
          return _mobileLayout();
        },
      ),
    );
  }

  Widget _webLayout() {
    return Scaffold(
      backgroundColor: const Color(0xff17203A),
      body: Row(
        children: [
          SizedBox(width: 250, child: const SideMenueBar()),

          Expanded(
            child: Obx(
              () => Scaffold(
                backgroundColor: Colors.white,
                appBar: _buildAppBar(),
                body: controller.pages[controller.selectedindex.value],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: controller.selectedtext.value,
      leading: null,
      actions: [
        if ([1, 3, 7].contains(controller.selectedindex.value))
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.addObject,
          ),
      ],
    );
  }

  Widget _tabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          //  NavigationRail
          Obx(
            () => NavigationRail(
              selectedIndex: controller.selectedindex.value,
              onDestinationSelected: (index) {
                controller.selectedindex.value = index;
                controller.selectedtext.value = controller.menus[index].title;
              },
              labelType: NavigationRailLabelType.selected,
              backgroundColor: const Color(0xff17203A),
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.white54),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("الرئيسية"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text("الموظفين"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.access_time),
                  label: Text("الحضور"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.event_note),
                  label: Text("الإجازات"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.perm_contact_cal),
                  label: Text("الأذونات"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.archive),
                  label: Text("الأرشيف"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.money),
                  label: Text("الرواتب"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_today),
                  label: Text("العطلات"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text("الملف الشخصي"),
                ),
              ],
            ),
          ),

          // 📄 المحتوى
          Expanded(
            child: Obx(
              () => Scaffold(
                appBar: CustomAppBar(
                  title: controller.selectedtext.value,
                  actions: [
                    if ([1, 3, 7].contains(controller.selectedindex.value))
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: controller.addObject,
                      ),
                  ],
                ),
                body: controller.pages[controller.selectedindex.value],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileLayout() {
    return Scaffold(
      body: Container(
        color: const Color(0xff17203A),
        child: Stack(
          children: [
            /// drawer
            const SideMenueBar(),

            /// main screen
            AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(controller.slideAnimation.value)
                    ..scale(controller.scaleAnimation.value),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      controller.isDrawerOpen.value ? 20 : 0,
                    ),
                    child: Obx(
                      () => Scaffold(
                        appBar: CustomAppBar(
                          title: controller.selectedtext.value,
                          leading: IconButton(
                            icon: Icon(
                              controller.isDrawerOpen.value
                                  ? Icons.close
                                  : Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: controller.toggleDrawer,
                          ),
                          actions: [
                            if ([
                              1,
                              3,
                              7,
                            ].contains(controller.selectedindex.value))
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  controller.addObject();
                                },
                              ),
                          ],
                        ),
                        body: controller.pages[controller.selectedindex.value],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
