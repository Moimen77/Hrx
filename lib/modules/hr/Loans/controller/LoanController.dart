import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:hrx/modules/hr/Loans/repo/LoanRepo.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdvanceArchiveController extends GetxController {
  final AdvanceArchiveRepo repo;
  AdvanceArchiveController(this.repo);

  late ActivityService activityService;
  final networkController = Get.find<NetworkController>();

  Future<void> approveLoan(AdvanceModel loan, double approvedAmount) async {
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        Get.back();
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      Get.back(); // Close Dialog
      isLoading.value = true;
      await repo.updateLoanStatus(loan.id!, 'مقبولة', approvedAmount);

      if (loan.employeeId != null) {
        FCMService fcm = FCMService();
        String body = approvedAmount == (loan.requestedAmount ?? 0.0)
            ? "تم الموافقة علي طلبك"
            : "تم الموافقة علي سلفتك لكن بملبغ $approvedAmount";

        await fcm.sendNotification(
          title: 'رد السلفة',
          body: body,
          topic: loan.employeeId.toString(),
        );
        await activityService.log(
          type: ActivityType.approveAdvance,
          metadata: {
            "name": loan.employeeName,
            "requested_amount": loan.requestedAmount,
            "approved_amount": approvedAmount,
          },
        );
      }

      AppSnack.success('نجاح', 'تمت الموافقة على السلفة بنجاح');
      await fetchUserAdvances();
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء الموافقة على الطلب');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectLoan(AdvanceModel advance) async {
    try {
      await networkController.checkInternet();
      if (!networkController.isConnected.value) {
        Get.back();
        AppSnack.error('حدث خطأ', 'لا يوجد اتصال بالإنترنت');
        return;
      }
      await repo.updateLoanStatus(advance.id!, 'مرفوضة', null);
      FCMService fcm = FCMService();
      await fcm.sendNotification(
        title: 'رد السلفة',
        body: "تم رفض طلبك",
        topic: advance.employeeId.toString(),
      );
      await activityService.log(
        type: ActivityType.rejectAdvance,
        metadata: {
          "name": advance.employeeName,
          "requested_amount": advance.requestedAmount,
        },
      );
      AppSnack.success('نجاح', 'تم رفض الطلب بنجاح');
      await fetchUserAdvances();
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء رفض الطلب');
    }
  }

  final RxBool isLoading = true.obs;
  final RxList<AdvanceModel> advances = <AdvanceModel>[].obs;

  var searchQuery = ''.obs;
  var selectedStatus = 'الكل'.obs;
  var dateRange = Rx<PickerDateRange?>(null);

  List<AdvanceModel> get filteredAdvances {
    return advances.where((loan) {
      final nameMatch =
          searchQuery.value.isEmpty ||
          (loan.employeeName?.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ??
              false);

      final statusMatch =
          selectedStatus.value == 'الكل' || loan.status == selectedStatus.value;

      bool dateMatch = true;
      if (dateRange.value != null && dateRange.value!.startDate != null) {
        final start = dateRange.value!.startDate!;
        final end = dateRange.value!.endDate ?? start;
        final loanDate = loan.requestDate ?? DateTime.now();
        dateMatch =
            loanDate.isAfter(start.subtract(const Duration(seconds: 1))) &&
            loanDate.isBefore(end.add(const Duration(days: 1)));
      }

      return nameMatch && statusMatch && dateMatch;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    activityService = Get.find<ActivityService>();
    fetchUserAdvances();
  }

  Future<void> fetchUserAdvances() async {
    try {
      isLoading.value = true;
      // if (!networkController.isConnected.value) {
      //   return;
      // }
      final result = await repo.fetchAdvances();
      advances.assignAll(result);
    } catch (e) {
      AppSnack.error('خطأ', 'فشل في تحميل سجل السلف');
    } finally {
      isLoading.value = false;
    }
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
