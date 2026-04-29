import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/PenalitesModel.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesRepo.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PenaltyController extends GetxController {
  final PenaltyRepository repo;

  PenaltyController(this.repo);

  var penalties = <PenaltyModel>[].obs;
  var isLoading = false.obs;
  FCMService fcmService = FCMService();
  final networkController = Get.find<NetworkController>();
  late ActivityService activityService;

  var searchQuery = ''.obs;
  var dateRange = Rx<PickerDateRange?>(null);

  List<PenaltyModel> get filteredPenalties {
    return penalties.where((penalty) {
      final nameMatch =
          searchQuery.value.isEmpty ||
          (penalty.employee?.name?.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ??
              false);

      bool dateMatch = true;
      if (dateRange.value != null && dateRange.value!.startDate != null) {
        final start = dateRange.value!.startDate!;
        final end = dateRange.value!.endDate ?? start;
        dateMatch =
            penalty.penaltyDate.isAfter(
              start.subtract(const Duration(seconds: 1)),
            ) &&
            penalty.penaltyDate.isBefore(end.add(const Duration(days: 1)));
      }

      return nameMatch && dateMatch;
    }).toList();
  }

  @override
  void onInit() {
    fetchPenalties();
    activityService = Get.find<ActivityService>();
    super.onInit();
  }

  Future<void> fetchPenalties() async {
    try {
      isLoading.value = true;
      if (!networkController.isConnected.value) {
        return;
      }
      penalties.value = await repo.fetchPenalties();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    fetchPenalties();
    await Get.find<HomeController>().fetchHomeData();
  }

  Future<void> updatePenaltyAmount(
    int id,
    double amount,
    int empID,
    String empName,
  ) async {
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        Get.back();
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      await repo.updatePenaltyAmount(id, amount);
      AppSnack.success('تم التحديث', 'تم تحديث القيمة بنجاح');
      fcmService.sendNotification(
        title: 'تعديل الجزاء',
        body: 'تم تعديل قيمة الجزاء',
        topic: empID.toString(),
      );
      await activityService.log(
        type: ActivityType.updatePenalty,
        employeeId: empID.toString(),
        metadata: {"name": empName},
      );
      await onRefresh();
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء تحديث القيمة');
    }
  }

  Future<void> cancelPenalty(PenaltyModel penalty) async {
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      final empID = penalty.employee?.id.toString();
      await repo.cancelPenalty(penalty.id);
      fetchPenalties();
      await activityService.log(
        type: ActivityType.cancelPenalty,
        metadata: {"name": penalty.employee?.name},
      );
      fcmService.sendNotification(
        title: 'الغاء الجزاء',
        body: 'تم الغاء الجزاء الخاص بكم',
        topic: empID.toString(),
      );
      await onRefresh();
      AppSnack.success('تم الألغاء', 'تم الغاء الجزاء بنجاح');
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء تحديث القيمة');
    }
  }

  void showEditDialog(PenaltyModel penalty) {
    RxDouble val = penalty.amountDay.toDouble().obs;
    Get.defaultDialog(
      title: 'تعديل قيمة الجزاء',
      titleStyle: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
      content: Obx(
        () => Column(
          children: [
            Text(
              '${val.value.toStringAsFixed(1)} ${penalty.isRival ? "جنيه" : "يوم"}',
              style: cairoStyle(
                fontSize: 18,
                fontweight: FontWeight.bold,
                fontcolor: Appcolors.primarycolor,
              ),
            ),
            Slider(
              value: val.value,
              min: 0,
              max: penalty.isRival ? 1000 : 30,
              divisions: penalty.isRival ? 200 : 60,
              onChanged: (v) => val.value = v,
              activeColor: Appcolors.primarycolor,
            ),
          ],
        ),
      ),
      textConfirm: 'حفظ',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      buttonColor: Appcolors.primarycolor,
      onConfirm: () {
        updatePenaltyAmount(
          penalty.id,
          val.value,
          penalty.employeeId,
          penalty.employee?.name ?? '',
        );
        Get.back();
      },
    );
  }

  void showDateFilterDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                onSelectionChanged: (args) {
                  if (args.value is PickerDateRange) {
                    dateRange.value = args.value;
                  }
                },
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: dateRange.value,
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: cairoStyle(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      dateRange.value = null;
                      Get.back();
                    },
                    child: Text(
                      'مسح',
                      style: cairoStyle(fontcolor: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'تم',
                      style: cairoStyle(fontcolor: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
