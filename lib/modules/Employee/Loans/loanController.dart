import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/Employee/Loans/loanRepo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';

class RequestAdvanceController extends GetxController with NetworkAwareMixin {
  final AdvanceRepo repo;
  RequestAdvanceController(this.repo);

  Myservices services = Get.find();
  ActivityService activityService = Get.find();

  // الحقول النصية
  late TextEditingController amountController;
  late TextEditingController noteController;
  int? employeeId;
  String? name;

  // مفتاح التحقق
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // حالة التحميل
  var isLoading = false.obs;
  var currentSliderValue = 0.0.obs;

  @override
  void onInit() {
    amountController = TextEditingController();
    noteController = TextEditingController();
    employeeId = int.parse(services.sharedPref.getString('id') ?? 1.toString());
    name = services.sharedPref.getString('name');
    super.onInit();
  }

  @override
  void onClose() {
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  Future<void> retryConnection() async {}

  Future<void> submitRequest(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    if (currentSliderValue.value <= 0) {
      showErrorDialog(context, "يرجى تحديد المبلغ المطلوب");
      return;
    }

    try {
      isLoading.value = true;
      if (!await ensureInternetConnection()) {
        return;
      }

      AdvanceModel request = AdvanceModel(
        employeeId: employeeId,
        requestedAmount: currentSliderValue.value,
        note: noteController.text,
        year: DateTime.now().year,
        month: DateTime.now().month,
      );

      var response = await repo.requestAdvance(request);

      if (response != null) {
        AppSnack.success("نجاح", "تم تقديم طلب السلفة بنجاح");

        await activityService.log(
          type: ActivityType.requestAdvance,
          metadata: {"amount": currentSliderValue.value, 'employee_name': name},
        );
        FCMService fcmService = FCMService();
        await fcmService.sendNotification(
          title: 'طلب سلفة جديد',
          body: 'الموظف $name طلب سلفة جديد مبلغ $currentSliderValue ج.م',
          topic: 'hr',
        );
        amountController.clear();
        Navigator.of(context).pop();
      } else {
        showErrorDialog(context, "حدث خطأ أثناء تقديم الطلب، حاول مرة أخرى");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
