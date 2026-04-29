import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/AttendanceFilter.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Employee/EmpAttendance/repo/AttendanceArciveRepo.dart';

class AttendanceArciveController extends GetxController with NetworkAwareMixin {
  final AttendanceRepository repo;

  AttendanceArciveController(this.repo);

  RxBool isLoading = false.obs;
  RxBool isFilterLoading = false.obs;
  RxList<EmployeeDayModel> records = <EmployeeDayModel>[].obs;
  Myservices services = Get.find();
  late String employeeId;
  AttendanceFilter filter = AttendanceFilter();

  // Filter states
  RxList<BranchModel> branches = <BranchModel>[].obs;
  final List<String> statuses = [
    'present',
    'late',
    'absent',
    'leave',
    'friday',
    'thursday',
  ];
  final Map<String, String> statusTranslations = {
    'present': 'حاضر',
    'late': 'متأخر',
    'absent': 'غائب',
    'leave': 'اجازة',
    'friday': 'الجمعة',
    'thursday': 'الخميس',
  };

  Rxn<DateTime> fromDate = Rxn<DateTime>();
  Rxn<DateTime> toDate = Rxn<DateTime>();

  Future<void> loadAttendance(String employeeId) async {
    try {
      isLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }

      var data = await repo.getAttendance(
        employeeId: int.parse(employeeId),
        filter: filter,
      );
      records.value = data;
    } catch (e) {
      print("❌ Attendance Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    filter
      ..fromDate = fromDate.value
      ..toDate = toDate.value;
    loadAttendance(employeeId);
  }

  void clearFilter() {
    filter = AttendanceFilter();
    fromDate.value = null;
    toDate.value = null;
    loadAttendance(employeeId);
  }

  Future<void> fetchBranches() async {
    try {
      isFilterLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      branches.value = await repo.getBranches();
    } catch (e) {
      print("❌ Error fetching branches: $e");
    } finally {
      isFilterLoading.value = false;
    }
  }

  Future<void> selectDateRange(context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: fromDate.value != null && toDate.value != null
          ? DateTimeRange(start: fromDate.value!, end: toDate.value!)
          : null,
    );
    if (picked != null) {
      fromDate.value = picked.start;
      toDate.value = picked.end;
    }
  }

  @override
  void onInit() {
    employeeId = services.sharedPref.getString('id')!;
    fetchBranches();
    loadAttendance(employeeId);
    super.onInit();
  }
}
