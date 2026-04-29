import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/AttendanceMode.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/data/models/departmentmodel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Department/controller/department_controller.dart';
import '../services/attendance_service.dart';

class AttendanceController extends GetxController with NetworkAwareMixin {
  final AttendanceService service = AttendanceService();

  late TextEditingController EmployeeName;
  RxString searchQuery = "".obs;

  RxBool isLoading = false.obs;
  RxList<EmployeeDayModel> attendanceList = <EmployeeDayModel>[].obs;

  DepartmentController departmentController = Get.find<DepartmentController>();

  DateTime selectedDate = DateTime.now();

  RxList<DepartmentModel> departments = <DepartmentModel>[].obs;
  RxString selectedDepartment = "الكل".obs;
  var haserror = false.obs;

  int total = 0;
  int present = 0;
  int absent = 0;
  int late = 0;

  @override
  void onInit() {
    EmployeeName = TextEditingController();

    /// أول ما الأقسام تتحدث أو تتحمل
    ever(departmentController.departments, (_) {
      _loadDepartments();
    });

    _loadDepartments(); // في حالة كانت اتحمّلت قبل ما الكونترولر يفتح

    fetchAttendance(); // تحميل أول مرة
    super.onInit();
  }

  Future<List<EmployeeDayModel>> getEmployeeDays(
    int employeeId,
    DateTime from,
    DateTime to,
  ) async {
    final hasInternet = await ensureInternetConnection(showMessage: false);
    if (!hasInternet) {
      return [];
    }
    return await service.getEmployeeDays(employeeId, from, to);
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2080),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff197fe6),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      changeDate(picked);
    }
  }

  /// تحميل الأقسام بشكل آمن
  void _loadDepartments() {
    final deptList = List<DepartmentModel>.from(
      departmentController.departments,
    );

    // إضافة "الكل" لو مش موجود
    if (!deptList.any((d) => d.name == "الكل")) {
      deptList.insert(0, DepartmentModel(id: 0, name: "الكل"));
    }

    departments.value = deptList;

    if (!departments.any((d) => d.name == selectedDepartment.value)) {
      selectedDepartment.value = "الكل";
    }
  }

  // تغيير القسم
  void changeDepartment(String dep) {
    selectedDepartment.value = dep;
    fetchAttendance();
  }

  // تغيير التاريخ
  void changeDate(DateTime date) {
    selectedDate = date;
    fetchAttendance();
  }

  // البحث
  void changeSearch(String value) {
    searchQuery.value = value;
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    isLoading.value = true;
    final hasInternet = await ensureInternetConnection(showMessage: false);
    if (!hasInternet) {
      isLoading.value = false;
      attendanceList.clear();
      return;
    }

    final String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    try {
      final data = await service.getAttendance(
        search: searchQuery.value,
        date: formattedDate,
        departmentName: selectedDepartment.value,
      );

      attendanceList.value = data;

      total = attendanceList.length;
      present = attendanceList.where((e) => e.status == "present").length;
      late = attendanceList.where((e) => e.late_penalty_type != null).length;

      absent = total - present - late;
    } catch (e) {
      haserror.value = true;
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء تحميل البيانات من الخادم');
    }
    isLoading.value = false;
  }

  // Manual check-in
  Future<void> checkIn(
    int employeeId,
    DateTime checkInTime,
    bool ispermisson,
    String? late_penalty_type,

    Attendancemode mode,
  ) async {
    if (!await ensureInternetConnection()) {
      return;
    }
    final isAlreadyChecked = await service.isAlreadyChecked(
      employeeId,
      checkInTime,
      mode,
    );
    if (isAlreadyChecked) {
      throw Exception("already_checked_in");
    }
    await service.manualCheckIn(
      employeeId,
      checkInTime,
      late_penalty_type,
      ispermisson,
    );
    fetchAttendance();
  }

  // Manual check-out
  Future<void> checkOut(
    int employee_id,
    DateTime finalTime,
    Attendancemode mode,
  ) async {
    if (!await ensureInternetConnection()) {
      return;
    }
    final isAlreadyChecked = await service.isAlreadyChecked(
      employee_id,
      finalTime,

      mode,
    );
    if (isAlreadyChecked) {
      print("Already checked out");
      throw Exception("already_checked_out");
    }
    await service.manualCheckOut(employee_id, finalTime);
    fetchAttendance();
  }

  /// Refresh screen عند الرجوع من الـ Home
  Future<void> refreshOnReturn() async {
    await fetchAttendance();
  }
}
