import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/departmentmodel.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/Repository/EmployeeRepository.dart';

class EmployeesController extends GetxController with NetworkAwareMixin {
  final EmployeeRepository repository;
  EmployeesController(this.repository);

  var employees = <EmployeeModel>[].obs;
  var departmentslist = <DepartmentModel>[].obs;
  var loading = false.obs;
  var hasError = false.obs;

  FCMService fcm = FCMService();

  // New state for filtering and searching
  var searchQuery = ''.obs;
  var selectedDepartment = 'الكل'.obs;

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  Future<RxList<EmployeeModel>> loadEmployees() async {
    loading.value = true;
    try {
      hasError.value = false;
      employees.value = await repository.getEmployees();
      departmentslist.value = await repository.getDepartments();
    } catch (e) {
      hasError.value = true;
    } finally {
      loading.value = false;
    }
    return employees;
  }

  Future<void> addPenalty({
    required int employeeId,
    required String type,
    required String reason,
    required double amount,
    required bool isPercentage,
    required DateTime date,
  }) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      await repository.createPenalty(
        employeeId: employeeId,
        type: type,
        reason: reason,
        amount: amount,
        isrival: isPercentage ? false : true,
        date: date,
      );

      AppSnack.success('تم', 'تم انزال الجزاء علي الموظف بنجاح');
      Navigator.of(Get.context!).pop();
      await fcm.sendNotification(
        title: 'جزاء',
        body: isPercentage
            ? 'تم إنزال جزاء عليك بقيمة $amount يوم'
            : 'تم انزال جزاء بقيمة $amount ج عليك',
        topic: employeeId.toString(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addBonus({
    required int employeeId,
    required String type,
    required String reason,
    required double amount,
    required bool isPercentage,
    required DateTime date,
  }) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      await repository.createBonus(
        employeeId: employeeId,
        reason: reason,
        amount: amount,
        isPercentage: isPercentage,
        date: date,
      );

      AppSnack.success('تم', 'تم عمل مكافأة علي الموظف بنجاح');
      await fcm.sendNotification(
        title: 'مكافأة إليك',
        body: 'تم انزال مكافأة بقيمة $amount  ج لك',
        topic: employeeId.toString(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // A computed list for the view to reactively update
  List<EmployeeModel> get filteredEmployees {
    if (employees.isEmpty) return [];

    return employees.where((emp) {
      final nameMatches = emp.name?.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );
      final departmentMatches =
          selectedDepartment.value == 'الكل' ||
          emp.departmentName == selectedDepartment.value;
      return (nameMatches ?? true) && departmentMatches;
    }).toList();
  }

  // A computed list of unique departments for the filter dropdown
  List<String> get departments {
    if (employees.isEmpty) return ['الكل'];

    final depts = employees.map((e) => e.departmentName ?? '').toSet().toList();
    depts.insert(0, 'الكل');
    return depts;
  }

  // Computed stats for the summary banner
  int get totalEmployeesCount => employees.length;
  int get activeEmployeesCount =>
      employees.where((e) => e.status == 'Active').length;
  int get departmentCount =>
      employees.map((e) => e.departmentName).toSet().length;

  // Methods to update filters
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateSelectedDepartment(String? department) {
    if (department != null) {
      selectedDepartment.value = department;
    }
  }

  Future<void> addEmployee(Map<String, dynamic> emp, String password) async {
    if (!await ensureInternetConnection()) {
      return;
    }
    await repository.addEmployee(emp, password);
    await loadEmployees();
  }

  Future<void> updateEmployee(Map<String, dynamic> emp, int id) async {
    if (!await ensureInternetConnection()) {
      return;
    }
    await repository.updateEmployee(emp, id);
    await loadEmployees();
  }

  Future<void> deleteEmployee(String id) async {
    if (!await ensureInternetConnection()) {
      return;
    }
    await repository.deleteEmployee(id);
    await loadEmployees();
  }
}
