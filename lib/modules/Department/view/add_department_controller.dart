// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/data/models/departmentmodel.dart';
import 'package:hrx/modules/Department/controller/department_controller.dart';

class AddDepartmentController extends GetxController {
  final DepartmentController _departmentController = Get.find();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  var isLoading = false.obs;

  Future<void> saveDepartment(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final newDepartment = DepartmentModel(name: nameController.text);
        await _departmentController.AddDepartment(newDepartment, context);
        _departmentController.fetchDepartments();
        AppSnack.success('تم بنجاح', 'تمت إضافة القسم بنجاح');
        Navigator.of(context).pop();
      } catch (e) {
        showErrorDialog(context, "حدث خطأ أثناء إضافة القسم: ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال اسم القسم';
    }
    if (value.length < 3) {
      return 'يجب أن يكون اسم القسم 3 أحرف على الأقل';
    }
    return null;
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
