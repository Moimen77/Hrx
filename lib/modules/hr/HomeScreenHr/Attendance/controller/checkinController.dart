import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/AttendanceMode.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';

class ManualAttendanceController extends GetxController with NetworkAwareMixin {
  RxString selectedEmployee = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  late AttendanceController attendanceController;
  late EmployeesController empController;
  late TextEditingController notesController;
  var haserror = false.obs;

  RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCheckinLoading = false.obs;

  Map<String, String> translateLate = {
    "لا يوجد": "none",
    "ربع يوم": "quarter",
    "نصف يوم": "half_day",
    "يوم كامل": "full_day",
  };

  var selectedDelay = "لا يوجد".obs;
  var hasPermission = false.obs;

  @override
  void onInit() {
    super.onInit();
    notesController = TextEditingController();
    attendanceController = Get.find<AttendanceController>();
    empController = Get.find<EmployeesController>();
    fetchEmployees();
  }

  EmployeeModel? get selectedEmployeeData {
    if (selectedEmployee.isEmpty) return null;
    return employees.firstWhere((e) => e.name == selectedEmployee.value);
  }

  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;
      haserror.value = false;
      final list = await empController.loadEmployees();
      print('Fetched Employees: ${list.length}');
      employees.assignAll(list);

      if (employees.isNotEmpty) {
        selectedEmployee.value = employees.first.name ?? "";
      }
    } catch (e) {
      haserror.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submit(Attendancemode mode, BuildContext context) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      if (selectedEmployee.value.isEmpty) {
        AppSnack.error("خطأ", "اختر موظف أولاً");
        return;
      }

      DateTime date = selectedDate.value;
      DateTime finalTime = DateTime(
        date.year,
        date.month,
        date.day,
        selectedTime.value.hour,
        selectedTime.value.minute,
      );

      isCheckinLoading.value = true;

      if (mode == Attendancemode.checkIn) {
        await attendanceController.checkIn(
          selectedEmployeeData!.id!,
          finalTime,
          hasPermission.value,
          selectedDelay.value == "لا يوجد"
              ? null
              : translateLate[selectedDelay.value],
          mode,
        );
        AppSnack.success("تم", "تم تسجيل الحضور");
      } else {
        await attendanceController.checkOut(
          selectedEmployeeData!.id!,
          finalTime,
          mode,
        );
        AppSnack.success("تم", "تم تسجيل الانصراف");
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      if (e.toString().contains("already_checked_in")) {
        showErrorDialog(context, "الموظف سجّل حضور مسبقًا");
      } else if (e.toString().contains("already_checked_out")) {
        showErrorDialog(context, "الموظف سجّل انصراف مسبقًا");
      } else if (e.toString().contains("no_open_attendance")) {
        showErrorDialog(context, "لا يوجد حضور مفتوح لهذا الموظف اليوم");
      } else {
        showErrorDialog(context, "حدث خطأ أثناء الحفظ");
      }
    } finally {
      isCheckinLoading.value = false;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      initialTime: selectedTime.value,
      context: context,
    );

    if (picked != null) {
      selectedTime.value = picked;
      update();
    }
  }
}
