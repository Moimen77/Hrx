import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/transaction_type_enum.dart';

class AddTransactionController extends GetxController {
  final EmployeesController _employeesController = Get.find();

  // Arguments passed from the previous screen
  late EmployeeModel employee;
  late TransactionType transactionType;

  // Form and text controllers
  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  final amountController = TextEditingController();
  final activityservice = Get.find<ActivityService>();

  // Reactive state variables
  var isLoading = false.obs;
  var isPercentage = false.obs;
  var transactionDate = DateTime.now().obs;
  var selectedType = ''.obs;

  // Dynamic lists and titles based on transaction type
  late List<String> availableTypes;
  late String pageTitle;
  late String saveButtonText;
  late String reasonHint;

  AddTransactionController() {
    // Receive arguments
    final args = Get.arguments as Map<String, dynamic>;
    employee = args['employee'] as EmployeeModel;
    transactionType = args['type'] as TransactionType;

    // Initialize UI elements based on type
    if (transactionType == TransactionType.penalty) {
      pageTitle = 'جزاء لـ: ${employee.name}';
      saveButtonText = 'حفظ الجزاء';
      reasonHint = 'مثال: عدم الالتزام بمواعيد العمل';
      availableTypes = ['خصم إداري', 'تأخير', 'غياب', 'مخالفة أخرى'];
    } else {
      // Bonus
      pageTitle = 'مكافأة لـ: ${employee.name}';
      saveButtonText = 'حفظ المكافأة';
      reasonHint = 'مثال: أداء متميز في مشروع X';
      availableTypes = [
        'مكافأة أداء',
        'مكافأة استثنائية',
        'عيدية',
        'مكافأة أخرى',
      ];
    }
    selectedType.value = availableTypes.first;
  }

  void setSelectedType(String? newValue) {
    if (newValue != null) {
      selectedType.value = newValue;
    }
  }

  void toggleIsPercentage(bool value) {
    isPercentage.value = value;
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: transactionDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2080),
    );
    if (picked != null && picked != transactionDate.value) {
      transactionDate.value = picked;
    }
  }

  Future<void> saveTransaction() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      final penaltyAmount = double.tryParse(amountController.text) ?? 0.0;

      try {
        if (transactionType == TransactionType.penalty) {
          await _employeesController.addPenalty(
            employeeId: employee.id!,
            type: selectedType.value,
            reason: reasonController.text,
            amount: penaltyAmount,
            isPercentage: isPercentage.value,
            date: transactionDate.value,
          );

          await activityservice.log(
            type: ActivityType.addPenalty,
            employeeId: employee.id.toString(),
            metadata: {
              "employee_name": employee.name,
              "amount": penaltyAmount,
              "type": selectedType.value,
              "reason": reasonController.text,
              "is_percentage": isPercentage.value,
            },
          );
        } else {
          await _employeesController.addBonus(
            employeeId: employee.id!,
            type: selectedType.value,
            reason: reasonController.text,
            amount: penaltyAmount,
            isPercentage: isPercentage.value,
            date: transactionDate.value,
          );

          await activityservice.log(
            type: ActivityType.addBonus,
            employeeId: employee.id.toString(),
            metadata: {
              "employee_name": employee.name,
              "amount": penaltyAmount,
              "is_percentage": isPercentage.value,
            },
          );
        }
        await Get.find<HomeController>().fetchHomeData();
        Get.back(); // Close the screen on success
      } catch (e) {
        AppSnack.error("خطأ", "حدث خطأ أثناء حفظ الإجراء");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    reasonController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
