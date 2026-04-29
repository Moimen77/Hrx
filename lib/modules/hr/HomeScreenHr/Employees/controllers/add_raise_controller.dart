import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/services/raise_service.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddRaiseController extends GetxController {
  final EmployeeModel employee;
  final RaiseService _raiseService = RaiseService();
  late ActivityService activityService;

  AddRaiseController({required this.employee}) {
    activityService = Get.find<ActivityService>();
  }

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  final selectedDate = Rx<DateTime?>(null);
  final isLoading = false.obs;

  @override
  void onClose() {
    amountController.dispose();
    dateController.dispose();
    super.onClose();
  }

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2080),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> submit() async {
    if (isLoading.value) return;
    if (!formKey.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(amountController.text);

    isLoading.value = true;

    try {
      await _raiseService.createEmployeeRaise(
        employeeId: employee.id!,
        amount: amount!,
        effectiveDate: selectedDate.value!,
      );
      await activityService.log(
        type: ActivityType.addRaise,
        employeeId: employee.id.toString(),
        metadata: {"employee_name": employee.name, "amount": amount},
      );
      Get.back();
      await Get.find<EmployeesController>().loadEmployees();
      await Get.find<HomeController>().fetchHomeData();
      AppSnack.success('تمت العملية بنجاح', 'تم إضافة الزيادة بنجاح');
    } on PostgrestException catch (e) {
      AppSnack.error('خطأ في قاعدة البيانات', 'حدث خطأ: ${e.message}');
    } catch (e) {
      AppSnack.error('خطأ', 'حدث خطأ غير متوقع');
    } finally {
      isLoading.value = false;
    }
  }
}
