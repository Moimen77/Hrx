import 'package:get/get_navigation/get_navigation.dart';
import 'package:hrx/modules/Auth/binding/CheckemailNinding.dart';
import 'package:hrx/modules/Auth/binding/ReseetPasswordBinding.dart'
    show Reseetpasswordbinding;
import 'package:hrx/modules/Auth/binding/authBinding.dart';
import 'package:hrx/modules/Auth/view/CheckEmail.dart';
import 'package:hrx/modules/Auth/view/ReseetPassword.dart';
import 'package:hrx/modules/Auth/view/inactive_account_view.dart';
import 'package:hrx/modules/Auth/view/login.dart';
import 'package:hrx/modules/Employee/EmpAttendance/view/CheckInView.dart';
import 'package:hrx/modules/Employee/HomeScreenEmployee/HomeScreen.dart';
import 'package:hrx/modules/Employee/HomeScreenEmployee/HomeScreenBinding.dart';
import 'package:hrx/modules/Employee/Leaves/Binding/RequestLeaveBinding.dart';
import 'package:hrx/modules/Employee/Leaves/view/LeaveRequest.dart';
import 'package:hrx/modules/Employee/Loans/loanBinding.dart';
import 'package:hrx/modules/Employee/Loans/loanView.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/binding/Manger_Response_Binding.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/binding/PermissionRequestBinding.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/view/Manger_Requests_Leave_View.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/view/PermissionRequestView.dart';
import 'package:hrx/modules/Employee/PermissionRequest/binding/ManagerPermissionBinding.dart';
import 'package:hrx/modules/Employee/PermissionRequest/view/ManagerPermissionView.dart';
import 'package:hrx/modules/Employee/substitute/Binding/substitute_binding.dart';
import 'package:hrx/modules/Employee/substitute/view/substitute_view.dart';
import 'package:hrx/modules/hr/Bonuses/BonusView.dart';

import 'package:hrx/modules/Department/view/AddDepartmentView.dart';
import 'package:hrx/modules/Department/view/DepartmentView.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/Binding/AttendanceBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/view/attendance_screen.dart'
    show AttendanceScreen;
import 'package:hrx/modules/hr/HomeScreenHr/Employees/binding/AddEmployeeBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/binding/EmployeesBinding.dart'
    show EmployeesBinding;
import 'package:hrx/modules/hr/HomeScreenHr/Employees/view/AddEmployeeView.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/view/EmployeesView.dart';
import 'package:hrx/modules/hr/HomeScreenHr/HomeScreen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/HomeScreenBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/binding/leaveBinding.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/view/AddLeaveScreen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/view/LeaveViewScreen.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/binding/AddBranchLocationBinding.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/binding/AddBranchLocationDeatils.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/view/AddBranchDetailsScreen.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/view/AddBranchLocationView.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/view/Branch_View.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/view/ProfileScreen.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/binding/ShiftsBinding.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/view/ShiftsView.dart';
import 'package:hrx/modules/OnboardingScreen/binding/onboarding_binding.dart';
import 'package:hrx/modules/OnboardingScreen/view/onboarding_view.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesBinding.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesView.dart';
import 'package:hrx/modules/Splash/view/splash.dart';
import 'package:hrx/modules/hr/Bonuses/BonusBinding.dart';
import 'package:hrx/routes/app_pages.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordView(),
      binding: Reseetpasswordbinding(),
    ),
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.sendemail,
      page: () => ForgetpasseordPage(),
      binding: CheckemailBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => Homescreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.employees,
      page: () => EmployeesListView(),
      binding: EmployeesBinding(),
    ),
    GetPage(
      name: AppRoutes.addEmployee,
      page: () => AddEmployeeView(),
      binding: Addemployeebinding(),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => AttendanceScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.leaves,
      page: () => LeaveScreen(),
      binding: LeaveBinding(),
    ),
    GetPage(name: AppRoutes.addLeave, page: () => AddLeaveScreen()),
    GetPage(name: AppRoutes.mainprofile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.branches, page: () => BranchesScreen()),
    GetPage(
      name: AppRoutes.addBranch,
      page: () => AddBranchLocationView(),
      binding: AddBranchLocationBinding(),
    ),
    GetPage(
      name: AppRoutes.addBranchDetails,
      page: () => AddBranchDetailsScreen(),
      binding: AddBranchLocationDeatils(),
    ),
    GetPage(name: AppRoutes.departments, page: () => DepartmentsScreen()),
    GetPage(name: AppRoutes.addDepartment, page: () => AddDepartmentScreen()),
    GetPage(
      name: AppRoutes.shifts,
      page: () => ShiftScreen(),
      binding: Shiftsbinding(),
    ),
    GetPage(
      name: AppRoutes.bonuses,
      page: () => BonusScreen(),
      binding: Bonusbinding(),
    ),
    GetPage(
      name: AppRoutes.rival,
      page: () => PenaltyScreen(),
      binding: Penalitesbinding(),
    ),
    //=================================================================Employees App==========================
    GetPage(
      name: AppRoutes.empHome,
      page: () => EmpHomescreen(),
      binding: Homescreenbinding(),
    ),
    GetPage(
      name: AppRoutes.substitute,
      page: () => SubstituteView(),
      binding: SubstituteBinding(),
    ),
    GetPage(
      name: AppRoutes.requestLeave,
      page: () => LeaveRequestView(),
      binding: Requestleavebinding(),
    ),
    GetPage(
      name: AppRoutes.addpermission,
      page: () => PermissionRequestView(),
      binding: PermissionRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.subminLoan,
      page: () => RequestAdvanceView(),
      binding: Loanbinding(),
    ),
    GetPage(name: AppRoutes.checkInOut, page: () => AttendancePage()),
    GetPage(
      name: AppRoutes.mangerResponse,
      page: () => ManagerLeavesView(),
      binding: ManagerLeavesBinding(),
    ),
    GetPage(
      name: AppRoutes.permissionReequest,
      page: () => ManagerPermissionView(),
      binding: ManagerPermissionBinding(),
    ),
    GetPage(
      name: AppRoutes.inactiveAccount,
      page: () => const InactiveAccountView(),
    ),
  ];
}
