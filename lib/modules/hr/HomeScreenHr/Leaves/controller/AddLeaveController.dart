import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';

class AddLeaveController extends GetxController {
  final LeaveController leaveController = Get.find();
  late EmployeesController _employeesController;

  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  EmployeeModel? selectedEmployee = null;
  RxList<EmployeeModel> employees = <EmployeeModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSubmitloading = false.obs;

  // بيانات النموذج
  RxString leaveType = 'مقبولة'.obs;
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);

  RxString selectedLeaveSubType = 'اعتيادي'.obs;
  final List<String> leaveSubTypeOptions = ['اعتيادي', 'عارضة'];

  Rx<String?> selectedPenalty = Rx<String?>(null);
  final List<Map<String, dynamic>> penaltyOptions = [
    {"label": 'لا يوجد', 'value': null},
    {"label": 'خصم يوم واحد', 'value': '1'},
    {"label": 'خصم يومين', 'value': '2'},
    {"label": 'خصم ثلاثة ايام', 'value': '3'},
  ];

  final List<String> leaveTypes = ['مقبولة', 'مرفوضة'];

  void setLeaveType(String? newValue) {
    if (newValue != null) {
      leaveType.value = newValue;
    }
  }

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2080),
    );

    if (picked != null) {
      if (isStartDate) {
        startDate.value = picked;
      } else {
        endDate.value = picked;
      }
    }
  }

  Future<void> submitLeave(BuildContext context) async {
    if (startDate.value == null || endDate.value == null) {
      showErrorDialog(context, "الرجاء تحديد تاريخ البدء والانتهاء");
      return;
    }
    if (endDate.value!.isBefore(startDate.value!)) {
      showErrorDialog(context, "تاريخ الانتهاء يجب أن يكون بعد تاريخ البدء");
      return;
    }
    isSubmitloading.value = true;

    try {
      final data = {
        'employee_id': selectedEmployee!.id,
        'type': leaveType.value == 'مقبولة' ? selectedLeaveSubType.value : '',
        'start_date': startDate.value!.toIso8601String(),
        'end_date': endDate.value!.toIso8601String(),
        'notes': reasonController.text,
        // replace with numper of days,
        'hr_decision': leaveType.value == 'مرفوضة'
            ? selectedPenalty.value
            : null,
        'status': leaveType.value, // الحالة الافتراضية عند إنشاء الطلب
      };
      print(data);

      await leaveController.addLeave(data);

      leaveController.fetchLeaves();
      Get.back(); // العودة بعد النجاح

      AppSnack.success("تم بنجاح", "تم تسجيل الإجازة بنجاح");
    } catch (e) {
      AppSnack.error("خطأ", "حدث خطأ أثناء إرسال الطلب: ${e.toString()}");
    } finally {
      isSubmitloading.value = false;
    }
  }

  featchEmployees() async {
    isLoading.value = true;

    final list = await _employeesController.loadEmployees();
    employees.assignAll(list);
    selectedEmployee = employees.first;
    print(employees.length);
    isLoading.value = false;
  }

  @override
  void onInit() {
    _employeesController = Get.find<EmployeesController>();
    featchEmployees();
    super.onInit();
  }

  @override
  void onClose() {
    reasonController.dispose();

    super.onClose();
  }
}
