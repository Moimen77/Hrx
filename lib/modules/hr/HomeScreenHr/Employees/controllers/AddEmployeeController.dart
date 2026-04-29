import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/departmentmodel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';

enum EmployeeViewMode { add, edit }

class AddEmployeeController extends GetxController {
  final EmployeesController _employeesController = Get.find();

  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController salaryController;
  late TextEditingController qualificationController;
  late TextEditingController gradeController;
  late TextEditingController experienceController;
  late TextEditingController seniorityController;
  late TextEditingController otherSalaryController;
  late TextEditingController departmentController;
  late TextEditingController shiftPriceController;

  RxString employeeType = 'full_time'.obs;

  var status = 'Active'.obs; // 'active' or 'inactive'
  var isManager = false.obs;

  late EmployeeViewMode mode;

  EmployeeModel? employee;

  final selectedDepartment = Rxn<DepartmentModel>();
  // 'active' or 'inactive'

  var isLoading = false.obs;

  var availableDepartments = <DepartmentModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    availableDepartments.value = _employeesController.departmentslist;

    final arguments = Get.arguments as Map<String, dynamic>?;
    mode = arguments?['mode'] as EmployeeViewMode? ?? EmployeeViewMode.add;
    if (mode == EmployeeViewMode.edit) {
      employee = arguments?['employee'] as EmployeeModel?;

      nameController = TextEditingController(text: employee!.name);
      emailController = TextEditingController(text: employee!.email);
      phoneController = TextEditingController(text: employee!.phone);
      salaryController = TextEditingController(
        text: employee!.salary.toString(),
      );
      qualificationController = TextEditingController(
        text: employee!.qualification ?? '',
      );

      gradeController = TextEditingController(
        text: employee!.jobGrade.toString(),
      );
      experienceController = TextEditingController(
        text: employee!.experienceSalary.toString(),
      );
      seniorityController = TextEditingController(
        text: employee!.yearsNumberEmployement.toString(),
      );
      otherSalaryController = TextEditingController(
        text: employee!.otherSalary.toString(),
      );
      passwordController = TextEditingController();
      departmentController = TextEditingController(
        text: employee!.departmentName!,
      );
      shiftPriceController = TextEditingController(
        text: employee!.shiftPrice.toString(),
      );
      selectedDepartment.value = availableDepartments.firstWhere(
        (element) => element.id == employee!.departmentId,
      );
      status.value = employee!.status ?? 'Active';
      isManager.value = employee!.isManger ?? false;
      employeeType.value = employee!.employeeType ?? 'full_time';
    } else {
      if (availableDepartments.isNotEmpty) {
        selectedDepartment.value = availableDepartments.first;
      }
      nameController = TextEditingController();
      emailController = TextEditingController();
      phoneController = TextEditingController();
      passwordController = TextEditingController();
      salaryController = TextEditingController();
      qualificationController = TextEditingController();
      gradeController = TextEditingController();
      experienceController = TextEditingController();
      seniorityController = TextEditingController();
      otherSalaryController = TextEditingController();
      departmentController = TextEditingController();
      shiftPriceController = TextEditingController();
      isManager.value = false;
      status.value = 'Active';
    }
  }

  void setStatus(String? newValue) {
    if (newValue != null) {
      status.value = newValue;
    }
  }

  Future<void> saveEmployee(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      final newEmployee = EmployeeModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        isManger: isManager.value,
        qualification: qualificationController.text,
        yearsNumberEmployement: int.tryParse(seniorityController.text) ?? 0,
        experienceSalary: int.tryParse(experienceController.text) ?? 0,
        otherSalary: int.tryParse(otherSalaryController.text) ?? 0,
        jobGrade: int.tryParse(salaryController.text) ?? 0,
        salary: double.tryParse(salaryController.text) ?? 0.0,
        status: status.value,
        departmentId: selectedDepartment.value!.id!,
        appointmentDate: DateTime.now(),
        employeeType: employeeType.value,
        shiftPrice: double.tryParse(shiftPriceController.text) ?? 0.0,
      ).toJson();

      try {
        if (mode == EmployeeViewMode.edit) {
          final int id = employee!.id!;
          await _employeesController.updateEmployee(newEmployee, id);
        } else {
          await _employeesController.addEmployee(
            newEmployee,
            passwordController.text,
          );
        }
        Navigator.of(context).pop();
        AppSnack.success('تمت العملية بنجاح', 'تم أضافة الموظف بنجاح');
      } catch (e) {
        AppSnack.error("خطأ", "حدث خطأ أثناء إضافة الموظف");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    seniorityController.dispose();
    qualificationController.dispose();
    gradeController.dispose();
    passwordController.dispose();
    otherSalaryController.dispose();
    salaryController.dispose();
    departmentController.dispose();
    super.onClose();
  }
}
