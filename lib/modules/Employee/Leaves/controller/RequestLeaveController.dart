// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/LeaveBalanceModel.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Leaves/repo/LeaveRepo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';

class LeaveController extends GetxController with NetworkAwareMixin {
  final LeaveRepository repo;
  late Homepagecontroller controller;
  LeaveController(this.repo);
  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  late EmployeeLeaveBalance? leaveBalance;
  Myservices myservices = Get.find();
  final formKey = GlobalKey<FormState>();

  late ActivityService activityService;

  // Form Data
  RxString type = "".obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString reason = "".obs;

  Rx<EmployeeModel?> selectedManager = (null as EmployeeModel?).obs;
  Rx<EmployeeModel?> selectedEmployee = (null as EmployeeModel?).obs;
  RxBool isAllEmployeesSelected = false.obs;
  RxList<EmployeeModel> managersList = <EmployeeModel>[].obs;
  RxList<EmployeeModel> employeesList = <EmployeeModel>[].obs;
  EmployeeModel? get CurrentEmployee => controller.Employee;

  bool get Ismanger => controller.Employee?.isManger ?? false;

  int? get employeeId => controller.Employee?.id;

  DateTime? get appoimentDate => controller.Employee?.appointmentDate;
  Future<void> submitLeave(int employeeId, BuildContext context) async {
    isLoading.value = true;
    final employee = controller.Employee;
    if (!await ensureInternetConnection()) {
      isLoading.value = false;
      return;
    }
    if (employee == null) {
      showErrorDialog(context, "بيانات الموظف غير متاحة");
      isLoading.value = false;
      return;
    }

    final LeaveDays = await repo.calculateWorkingDays(
      startDate: startDate.value,
      endDate: endDate.value,
      employeeId: employeeId,
    );
    try {
      if (type.value.isEmpty) {
        showErrorDialog(context, 'يرجى اختيار نوع الإجازة');
        isLoading.value = false;
        return;
      }

      if (leaveBalance != null) {
        if (type.value == 'اعتيادي') {
          final daysAvaliable =
              leaveBalance!.annualTotal - leaveBalance!.annualUsed;

          if (daysAvaliable < LeaveDays) {
            showErrorDialog(
              context,
              ' عفواً، لا يوجد رصيد لهذه الأجازة من الأجازات الأعتيادية',
            );
            isLoading.value = false;
            return;
          }
        } else if (type.value == 'عارضة') {
          final daysAvaliable =
              leaveBalance!.casualTotal - leaveBalance!.casualUsed;
          if (LeaveDays > daysAvaliable) {
            showErrorDialog(
              context,
              'عفواً، لا  يوجد لهذه الأجازة  رصيد من الإجازات العارضة ',
            );
            isLoading.value = false;
            return;
          }
        }
      }

      if (!isAllEmployeesSelected.value && selectedEmployee.value == null) {
        showErrorDialog(context, 'يرجى اختيار موظف بديل أو تحديد كل الموظفين');
        isLoading.value = false;
        return;
      }

      LeaveModel leave = LeaveModel(
        employeeId: employeeId,
        leaveType: type.value,
        startDate: startDate.value,
        endDate: endDate.value,
        notes: reason.value,
        status: 'معلقة',
      );

      await repo.requestLeave(leave);
      await activityService.log(
        type: ActivityType.requestLeave,
        employeeId: employeeId.toString(),
        metadata: {
          "employee_name": controller.Employee!.name,
          "type": type.value,
          "days": LeaveDays,
          "start_date": startDate.value.toString(),
          "end_date": endDate.value.toString(),
        },
      );
      FCMService fcm = FCMService();
      String topic;
      if (isAllEmployeesSelected.value) {
        topic = 'Dep${myservices.sharedPref.getString('department_id')}';
      } else {
        topic = selectedEmployee.value!.id.toString();
      }
      await fcm.sendNotification(
        title: 'طلب بديل',
        body: '${controller.Employee!.name} طلب بديل لأجازة',
        topic: topic,
      );
      if (!Ismanger) {
        await fcm.sendNotification(
          title: 'طلب بديل',
          body: '${controller.Employee!.name} طلب بديل لأجازة',
          topic: selectedManager.value!.id.toString(),
        );
      }
      await Get.find<Homepagecontroller>().loadall();
      AppSnack.success('تم', 'تم ارسال طلب الأجازة بنجاح');
      Navigator.of(context).pop();
    } catch (e) {
      showErrorDialog(context, 'حدث خطأ');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadInitialData() async {
    try {
      isDataLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      managersList.value = await repo.getManagers();

      final departmentIdString = myservices.sharedPref.getString(
        'department_id',
      );
      if (departmentIdString != null) {
        final departmentId = int.tryParse(departmentIdString);
        if (departmentId != null) {
          final allDeptEmployees = await repo.getDepartmentEmployees(
            departmentId,
          );

          leaveBalance = await repo.getEmployeeLeaveBalance(employeeId!);
          employeesList.value = allDeptEmployees
              .where((emp) => emp.id != employeeId)
              .toList();
        }
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل بيانات الموظفين: ${e.toString()}');
    } finally {
      isDataLoading.value = false;
    }
  }

  @override
  void onInit() {
    controller = Get.find<Homepagecontroller>();
    activityService = Get.find<ActivityService>();
    loadInitialData();
    super.onInit();
  }
}
