import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/RiveUtils.dart';
import 'package:hrx/data/models/RiveModels.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_controller.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_view.dart';
import 'package:hrx/modules/hr/EmployeeSalary/view/EmployeeSalaryView.dart';
import 'package:hrx/modules/hr/HomePageHr/view/HrHomeScreen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/view/attendance_screen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/view/EmployeesView.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/view/LeaveViewScreen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/view/PermissionView.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/view/ProfileScreen.dart';
import 'package:hrx/modules/hr/Loans/view/LoanView.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:rive/rive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homescreencontroller extends GetxController
    with GetSingleTickerProviderStateMixin {
  final SupabaseClient _client = Supabase.instance.client;
  final Myservices myservices = Get.find();

  // State from SideMenueBar moved here
  final List<riveModels> menus = riveModels.models;
  late Rx<riveModels> selectedMenu;

  // State for page navigation from HomeScreen
  var selectedindex = 0.obs;
  var selectedtext = ''.obs;

  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> slideAnimation;
  var isDrawerOpen = false.obs;

  final List<Widget> pages = [
    HrHomeScreen(),
    EmployeesListView(),
    AttendanceScreen(),
    const LeaveScreen(),
    PermissionView(),
    AdvanceArchiveView(),
    SalaryScreen(),
    OfficialHolidaysView(),
    const ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    validateHrAccess();
    // Initialize with the first menu item
    final firstMenu = menus.first;
    selectedMenu = firstMenu.obs;
    selectedindex.value = firstMenu.pagenum;
    selectedtext.value = firstMenu.title;

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(animationController);
    slideAnimation = Tween<double>(
      begin: 0,
      end: 250,
    ).animate(animationController);
  }

  Future<void> validateHrAccess() async {
    final currentUser = _client.auth.currentUser;
    if (currentUser == null) {
      myservices.sharedPref.setBool('IsLogin', false);
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final hr = await _client
        .from('Hrs')
        .select('is_active')
        .eq('user_id', currentUser.id)
        .maybeSingle();

    final isActive = hr?['is_active'] == true;
    myservices.sharedPref.setBool('IsActive', isActive);

    if (!isActive) {
      Get.offAllNamed(AppRoutes.inactiveAccount);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void toggleDrawer() {
    if (isDrawerOpen.value) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void onMenuTap(riveModels menu) async {
    selectedMenu.value = menu;
    selectedindex.value = menu.pagenum;
    selectedtext.value = menu.title;
    for (var m in menus) {
      m.input?.change(m == menu);
    }
    await Future.delayed(const Duration(milliseconds: 250));
    toggleDrawer();
  }

  addObject() {
    switch (selectedindex.value) {
      case 1:
        Get.toNamed(AppRoutes.addEmployee);
        break;
      case 3:
        Get.toNamed(AppRoutes.addLeave);
        break;
      case 7:
        Get.find<OfficialHolidaysController>().showAddDialog();
        break;
    }
  }

  void onRiveInit(Artboard artboard, riveModels menu) {
    StateMachineController? controller = riveUtils.getRiveController(
      artboard,
      menu.stateMachineName!,
    );
    final input = controller.findSMI<SMIBool>('active');
    if (input != null) {
      menu.input = input;
      input.change(menu == selectedMenu.value);
    }
  }
}
