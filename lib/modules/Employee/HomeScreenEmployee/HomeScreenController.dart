import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/EmpAttendance/view/AttendaceArchiveView.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/View/employee_leaves_view.dart';
import 'package:hrx/modules/Employee/HomePage/view/HomePageView.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveView.dart';
import 'package:hrx/modules/Employee/Permissions/view/Permission_View.dart';
import 'package:hrx/modules/Employee/Profile/view/ProfileScreen.dart';

class Homescreencontroller extends GetxController {
  int selectedindex = 0;
  List<Widget> pages = [
    HomepageView(),
    Attendacearchiveview(),
    EmployeeLeavesView(),
    PermissionView(),
    AdvanceArchiveView(),
    ProfileScreen(),
  ];
  changePage(int nextindex) {
    selectedindex = nextindex;
    update();
  }
}
