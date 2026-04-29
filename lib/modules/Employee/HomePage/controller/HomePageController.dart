// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/staticNumbers.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/activityModel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Employee/HomePage/repo/HomePageRepo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:hrx/routes/app_pages.dart';

class Homepagecontroller extends GetxController with NetworkAwareMixin {
  final Homepagerepo repo;
  Homepagecontroller(this.repo);
  RxList<EmployeeModel> Employees = <EmployeeModel>[].obs;
  RxList<EmployeeDayModel> attendances = <EmployeeDayModel>[].obs;
  RxList<ActivityLogModel> activities = <ActivityLogModel>[].obs;
  Myservices myservices = Get.find();
  int padgeCount = 0;
  FCMService fcm = FCMService();

  EmployeeModel? get Employee => Employees.isNotEmpty ? Employees.first : null;
  EmployeeDayModel? get attendance {
    if (attendances.isEmpty) {
      return null;
    }
    return attendances.first;
  }

  RxBool isloading = false.obs;
  RxBool isCheckoutloading = false.obs;
  Rx<Position?> currentPosition = (null as Position?).obs;

  bool get isCheckedIn =>
      attendances.isNotEmpty &&
      attendance != null &&
      attendance!.checkIn != null;

  bool get isCheckedOut =>
      attendances.isNotEmpty &&
      attendance != null &&
      attendance!.checkOut != null;

  loadall() async {
    try {
      isloading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      Employees.value = await repo.GetProfileData();
      if (Employee!.status != 'Active') {
        Get.offAllNamed(AppRoutes.inactiveAccount);
        myservices.sharedPref.setBool('IsActive', false);
        isloading.value = false;
        return;
      }
      padgeCount = await repo.getPageCount(
        Employee!.id!,
        Employee!.departmentId!,
      );
      attendances.value = await repo.GetTodayAttendance(Employee!.id!);
      activities.value = await repo.getRecentActivities(Employee!.id!);
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ: ${e.toString()}');
    } finally {
      isloading.value = false;
    }
  }

  Future<void> CheckOut(BuildContext context) async {
    try {
      isCheckoutloading.value = true;
      if (!await ensureInternetConnection()) {
        return;
      }

      if (Employee == null) {
        showErrorDialog(context, 'حدث خطأ: بيانات الموظف غير متاحة.');
        isCheckoutloading.value = false;
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showErrorDialog(context, "يرجى تمكين الموقع على الجهاز.");
        isCheckoutloading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showErrorDialog(context, "تم رفض صلاحية الموقع.");
          isCheckoutloading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showErrorDialog(context, "تم رفض صلاحية الموقع نهائيًا.");
        isCheckoutloading.value = false;
        return;
      }

      currentPosition.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (currentPosition.value == null) {
        showErrorDialog(context, "تعذر الحصول على الموقع الحالي.");
        isCheckoutloading.value = false;
        return;
      }

      if (attendance != null &&
          attendance!.lat != null &&
          attendance!.lng != null) {
        double distance = Geolocator.distanceBetween(
          attendance!.lat!,
          attendance!.lng!,
          currentPosition.value!.latitude,
          currentPosition.value!.longitude,
        );

        if (distance > avilableDistance) {
          showErrorDialog(
            context,
            "أنت خارج حدود الفرع، لا يمكن تسجيل الانصراف.",
          );
          isCheckoutloading.value = false;
          return;
        }
      }

      await repo.CheckOut(Employee!.id!);
      await fcm.sendNotification(
        title: 'تسجيل انصراف',
        body: 'الموظف ${Employee!.name} سجل انصراف',
        topic: 'hr',
      );
      await loadall();
    } catch (e) {
      showErrorDialog(context, 'حدث خطأ: ${e.toString()}');
    } finally {
      isCheckoutloading.value = false;
    }
  }

  @override
  void onInit() {
    loadall();
    super.onInit();
  }
}
