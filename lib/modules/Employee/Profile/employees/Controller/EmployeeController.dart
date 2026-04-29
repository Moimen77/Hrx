// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/modules/Employee/Profile/employees/Services/EmployeeDataservices.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Hrcontroller extends GetxController {
  final Hrdataservices hrdata = Get.put(Hrdataservices());
  final Myservices myservices = Get.find();
  RxBool isloading = false.obs;
  RxMap data = {}.obs;

  getdata() async {
    try {
      isloading.value = true;
      final res = await hrdata.GetprofileData();
      print(res);
      data = res[0].obs;
      print(data);
    } catch (e) {
    } finally {
      isloading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      // It's better to have this call inside your AuthRepository
      await Supabase.instance.client.auth.signOut();

      // Clear session flag
      await myservices.sharedPref.setBool('IsLogin', false);

      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      showErrorDialog(context, "حدث خطأ أثناء تسجيل الخروج: ${e.toString()}");
    } finally {}
  }

  @override
  void onInit() {
    super.onInit();
    print('here');
    getdata();
  }
}
