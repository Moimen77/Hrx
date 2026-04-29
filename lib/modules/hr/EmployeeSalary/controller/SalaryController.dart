import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/repo/EmployeeSalaryRepo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class SalaryController extends GetxController {
  final SalaryRepo repo;
  SalaryController(this.repo);

  var isLoading = false.obs;
  var salaryList = <SalaryResultModel>[].obs;
  late ActivityService activityService;
  final networkController = Get.find<NetworkController>();

  final now = DateTime.now();

  late Rx<DateTime> selectedDate;

  var searchQuery = ''.obs;
  var selectedSalaryType = 'الكل'.obs;

  final Map<String, String> salaryTypeLabels = {
    'الكل': 'الكل',
    'full_time': 'دوام كامل',
    'half_time': 'نصف دوام',
    'shifts': 'شيفتات',
    'marketing': 'تسويق',
  };

  List<SalaryResultModel> get filteredSalaries {
    return salaryList.where((salary) {
      final nameMatch =
          searchQuery.value.isEmpty ||
          salary.name.toLowerCase().contains(searchQuery.value.toLowerCase());

      final typeMatch =
          selectedSalaryType.value == 'الكل' ||
          (salary.salarytype != null &&
              salary.salarytype == selectedSalaryType.value);

      return nameMatch && typeMatch;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateTime(now.year, now.month - 1, now.day).obs;
    activityService = Get.find<ActivityService>();
    fetchAllSalaries();
  }

  Future<void> addAllowances(List<Map<String, dynamic>> allowances) async {
    try {
      await repo.addAllowances(allowances);
      AppSnack.success("نجاح", "تمت إضافة البدلات بنجاح.");
      await fetchAllSalaries();
    } catch (e) {
      AppSnack.error("خطأ", "حدث خطأ أثناء حفظ البدلات.");
    }
  }

  Future<void> recalcSalaryAfterAbsence(
    SalaryResultModel salary,
    int newAbsence,
  ) async {
    final updatedSalary = await repo.recalcSalaryAfterAbsence(
      salary,
      newAbsence,
    );
    updateSalary(updatedSalary);
  }

  void updateSalary(SalaryResultModel newSalary) {
    int index = salaryList.indexWhere((e) {
      return (e.employeeId == newSalary.employeeId);
    });

    if (index != -1) {
      salaryList[index] = newSalary;
      salaryList.refresh();
    }
  }

  Future<void> paySalary(SalaryResultModel salary) async {
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      final data = salary.toJson();
      await repo.paySalary(data);
      AppSnack.success("نجاح", "تم تسليم الراتب بنجاح.");
      FCMService fcmService = FCMService();
      final Map<String, dynamic> metadata = {
        'month': salary.month,
        'amount': salary.finalSalary.toStringAsFixed(1),
        'employee_name': salary.name,
      };
      await activityService.log(
        type: ActivityType.paySalary,
        employeeId: salary.employeeId.toString(),
        metadata: metadata,
      );
      await fcmService.sendNotification(
        title: 'تسليم الراتب',
        body: 'تم تسليم راتب شهر ${salary.month} لك بنجاح.',
        topic: salary.employeeId.toString(),
      );
      await fetchAllSalaries();
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء تسليم الراتب.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCases({
    required int employeeId,
    required int cases,
    required int dyeCases,
  }) async {
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      await repo.upsertShiftStats(
        employeeId: employeeId,
        year: selectedDate.value.year,
        month: selectedDate.value.month,
        cases: cases,
        dyeCases: dyeCases,
      );
      Navigator.of(Get.context!).pop();
      await fetchAllSalaries();
      AppSnack.success('نجاح', 'تم تحديث الحالة بنجاح.');
    } catch (e) {
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء تحديث الحالة.');
    }
  }

  Future<void> fetchAllSalaries() async {
    isLoading.value = true;
    try {
      if (!networkController.isConnected.value) {
        return;
      }
      final results = await repo.calculateAllSalaries(
        year: selectedDate.value.year,
        month: selectedDate.value.month,
      );
      salaryList.assignAll(results);
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء حساب الرواتب");
    } finally {
      isLoading.value = false;
    }
  }

  void updateDate() async {
    final selected = await showMonthPicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      int month = selected.month;
      int year = selected.year;
      selectedDate.value = DateTime(year, month, 1);
    }
    await fetchAllSalaries();
  }

  Future<void> updateHrScore(int employeeId, int score) async {
    Get.back();
    isLoading.value = true;
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      await repo.updateHrScore(
        employeeId: employeeId,
        year: selectedDate.value.year,
        month: selectedDate.value.month,
        score: score,
      );
      AppSnack.success("نجاح", "تم تحديث التقييم بنجاح");
      await fetchAllSalaries();
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء تحديث التقييم");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<AllowanceFieldControllers> allowanceFields =
      <AllowanceFieldControllers>[].obs;

  void initAllowanceFields() {
    allowanceFields.clear();
    allowanceFields.add(AllowanceFieldControllers());
  }

  void addAllowanceField() {
    allowanceFields.add(AllowanceFieldControllers());
  }

  void removeAllowanceField(int index) {
    if (index >= 0 && index < allowanceFields.length) {
      allowanceFields[index].dispose();
      allowanceFields.removeAt(index);
    }
  }

  void clearAllowanceFields() {
    for (var field in allowanceFields) {
      field.dispose();
    }
    allowanceFields.clear();
  }

  void saveAllowances(SalaryResultModel salary) {
    final List<Map<String, dynamic>> allowancesToSave = [];
    bool hasError = false;

    for (var field in allowanceFields) {
      final name = field.nameController.text.trim();
      final amountText = field.amountController.text.trim();

      if (name.isEmpty && amountText.isEmpty) {
        continue;
      }

      final amount = int.tryParse(amountText);

      if (name.isNotEmpty && amount != null && amount > 0) {
        allowancesToSave.add({
          'lieue_name': name,
          'lieue_amount': amount,
          'employee_id': salary.employeeId,
          'lieue_month': selectedDate.value.month,
          'lieue_year': selectedDate.value.year,
        });
      } else {
        hasError = true;
        break;
      }
    }

    if (hasError) {
      Get.snackbar(
        "خطأ في الإدخال",
        "تأكد من إدخال اسم ومبلغ صحيح لكل بدل.",
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
      return;
    }

    if (allowancesToSave.isNotEmpty) {
      addAllowances(allowancesToSave);
    }
  }

  RxInt hrScore = 0.obs;

  void initHrScore(int score) {
    hrScore.value = score;
  }

  void setHrScore(int value) {
    hrScore.value = value;
  }

  void incrementHrScore() {
    if (hrScore.value < 100) {
      hrScore.value = (hrScore.value + 5).clamp(0, 100);
    }
  }

  void decrementHrScore() {
    if (hrScore.value > 0) {
      hrScore.value = (hrScore.value - 5).clamp(0, 100);
    }
  }
}

class AllowanceFieldControllers {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}
