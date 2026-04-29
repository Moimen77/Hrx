import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/repo/PermissionRepo.dart';

class PermissionController extends GetxController with NetworkAwareMixin {
  final PermissionRepo repo;
  PermissionController(this.repo);
  late ActivityService activityservice;
  var haserror = false.obs;

  List<PerrmissionModel> allPermissions = [];

  List<PerrmissionModel> get permissions {
    return allPermissions.where((item) {
      final nameMatch =
          searchQuery.value.isEmpty ||
          (item.employeeName?.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ??
              false);

      var statusMatch = selectedStatus.value == 'الكل';
      if (selectedStatus.value != 'الكل') {
        switch (selectedStatus.value) {
          case 'مقبولة':
            statusMatch = item.hr_approve == true;
            break;
          case 'مرفوضة':
            statusMatch = item.hr_approve == false;
            break;
          default:
            statusMatch = item.hr_approve == null;
        }
      }

      bool dateMatch = true;
      if (dateRange.value != null) {
        final start = dateRange.value!.start;
        final end = dateRange.value!.end.add(const Duration(days: 1));
        dateMatch =
            item.perm_date.isAfter(
              start.subtract(const Duration(seconds: 1)),
            ) &&
            item.perm_date.isBefore(end);
      }

      return nameMatch && statusMatch && dateMatch;
    }).toList();
  }

  RxBool isLoading = false.obs;
  bool ismanager = false;

  var searchQuery = ''.obs;
  var selectedStatus = 'الكل'.obs;
  var dateRange = Rx<DateTimeRange?>(null);

  @override
  void onInit() {
    super.onInit();
    activityservice = Get.find<ActivityService>();
    fetchPermissions();
  }

  Future<void> fetchPermissions() async {
    isLoading.value = true;
    try {
      // final hasInternet = await ensureInternetConnection(showMessage: false);
      // if (!hasInternet) {
      //   allPermissions = [];
      //   return;
      // }
      haserror.value = false;

      final data = await repo.getPermissions();
      allPermissions = data.map((e) => PerrmissionModel.fromJson(e)).toList();
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء تحميل البيانات');
      haserror.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  setDateRange(DateTimeRange range) {
    dateRange.value = range;
  }

  Future<void> updateStatus(PerrmissionModel permission, bool status) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      await repo.updatePermissionStatus(permission.id!, status);
      Get.back();
      AppSnack.success("نجاح", status ? "تم قبول الطلب" : "تم رفض الطلب");
      if (status) {
        await repo.deduct_perrmission(permission.employeeId);
      }
      FCMService fcmService = FCMService();
      await fcmService.sendNotification(
        title: 'قرار الإذن',
        body: status ? 'تم اعتماد طلبك من ال Hr' : ' من ال Hr تم رفض طلبك',
        topic: permission.employeeId.toString(),
      );
      await activityservice.log(
        type: status
            ? ActivityType.approvePermission
            : ActivityType.rejectPermission,
        employeeId: permission.employeeId.toString(),
        metadata: {
          "employee_name": permission.employeeName,
          "date": permission.perm_date.toString(),
          'type': permission.perm_type == 'delay' ? 'تأخير' : 'انصراف',
        },
      );
      await Get.find<HomeController>().fetchHomeData();
      await fetchPermissions();
    } catch (e) {
      print(e);
      Get.back();
      Get.snackbar("خطأ", "حدث خطأ أثناء تحديث الحالة");
    }
  }
}
