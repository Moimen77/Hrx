// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/PermissionBalance.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/repo/PermissionRequestRepo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';

class PermissionRequestController extends GetxController with NetworkAwareMixin {
  final PermissionRequestRepo repo;
  PermissionRequestController(this.repo);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();
  final Myservices myServices = Get.find();
  bool ismangaer = false;

  // Observables
  RxString selectedType = 'delay'.obs;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  EmployeePermissionBalance? employeePermissionBalance;

  Rxn<int> selectedSubstituteId = Rxn<int>();
  Rxn<int> selectedManagerId = Rxn<int>();

  RxBool isallEmployeeSelected = false.obs;
  late int Currentdepartmentid;
  late int Currentemployeeid;
  String currentEmployeeName = '';

  RxList<EmployeeModel> employees = <EmployeeModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;

  final List<Map<String, String>> permissionTypes = [
    {'value': 'delay', 'label': 'تأخير'},
    {'value': 'departure', 'label': 'مغادرة'},
  ];

  @override
  void onInit() {
    super.onInit();
    Currentdepartmentid = int.parse(
      myServices.sharedPref.getString('department_id')!,
    );
    Currentemployeeid = int.parse(myServices.sharedPref.getString('id')!);
    ismangaer = myServices.sharedPref.getBool('isManager') ?? false;
    currentEmployeeName = myServices.sharedPref.getString('name')!;
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isDataLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      var data = await repo.getEmployees();
      employeePermissionBalance = await repo.getEmployeePermissionBalance(
        Currentemployeeid,
      );
      employees.assignAll(data);
    } catch (e) {
      AppSnack.error('خطأ', 'فشل في تحميل قائمة الموظفين');
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> submitRequest() async {
    if (!formKey.currentState!.validate()) return;
    if (!await ensureInternetConnection()) {
      return;
    }
    if (selectedDate.value == null) {
      showErrorDialog(Get.context!, 'يرجى اختيار التاريخ');
      return;
    }

    if (selectedSubstituteId.value == null) {
      showErrorDialog(Get.context!, 'يرجى اختيار موظف البديل');
      return;
    }
    if (employeePermissionBalance!.used >= 2) {
      showErrorDialog(Get.context!, 'لقد استهلكت رصيدك الشهري من الأذونات');
      return;
    }
    try {
      isLoading.value = true;
      String? userId = myServices.sharedPref.getString('id');

      if (userId == null) {
        Get.snackbar('خطأ', 'لم يتم العثور على معرف الموظف');
        return;
      }

      final permission = PerrmissionModel(
        employeeId: int.parse(userId),
        perm_type: selectedType.value,
        perm_date: selectedDate.value!,
        notes: notesController.text,
      );

      await repo.submitPermission(permission);
      FCMService fcmService = FCMService();
      await fcmService.sendNotification(
        title: 'طلب إذن جديد',
        body: 'طلب $currentEmployeeName أذن جديد منك',
        topic: isallEmployeeSelected.value
            ? 'Dep${Currentdepartmentid.toString()}'
            : selectedSubstituteId.toString(),
      );

      Get.back();
      Get.snackbar('نجاح', 'تم إرسال طلب الإذن بنجاح');
    } catch (e) {
      print("Error submitting permission: $e");
      Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال الطلب');
    } finally {
      isLoading.value = false;
    }
  }
}
