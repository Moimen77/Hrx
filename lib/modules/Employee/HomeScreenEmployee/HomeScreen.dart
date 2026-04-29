import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/AlertExitApp.dart';
import 'package:hrx/modules/Employee/HomeScreenEmployee/HomeScreenController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/HomeScreenWidget/bottomPages.dart';

class EmpHomescreen extends GetView<Homescreencontroller> {
  const EmpHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homescreencontroller>(
      builder: (controller) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return; // لو خرج خلاص
          showExitDialog(context);
        },
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 2,
            color: Colors.white,
            elevation: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Bottompages(
                  onTap: () {
                    controller.changePage(0);
                  },
                  title: 'الرئيسية',
                  icon: Icons.home,
                  isactive: controller.selectedindex == 0 ? true : false,
                ),
                Gap(10),
                Bottompages(
                  onTap: () {
                    controller.changePage(1);
                  },
                  title: 'الحضور',
                  icon: Icons.fingerprint,
                  isactive: controller.selectedindex == 1 ? true : false,
                ),
                Gap(10),
                Bottompages(
                  onTap: () {
                    controller.changePage(2);
                  },
                  title: 'الأجازات',
                  icon: Icons.hotel_outlined,
                  isactive: controller.selectedindex == 2 ? true : false,
                ),
                Gap(10),
                Bottompages(
                  onTap: () {
                    controller.changePage(3);
                  },
                  title: 'الأذونات',
                  icon: Icons.perm_device_information_outlined,
                  isactive: controller.selectedindex == 3 ? true : false,
                ),
                Gap(10),
                Bottompages(
                  onTap: () {
                    controller.changePage(4);
                  },
                  title: 'السلف',
                  icon: Icons.attach_money_outlined,
                  isactive: controller.selectedindex == 4 ? true : false,
                ),
                Gap(10),
                Bottompages(
                  onTap: () {
                    controller.changePage(5);
                  },
                  title: 'ملفي',
                  icon: Icons.person_outline_outlined,
                  isactive: controller.selectedindex == 5 ? true : false,
                ),
              ],
            ),
          ),
          body: controller.pages[controller.selectedindex],
        ),
      ),
    );
  }
}
