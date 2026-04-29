// ignore_for_file: empty_catches

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart' show showErrorDialog;
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Services/HrDataServices.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
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
      data = res[0].obs;
    } catch (e) {
    } finally {
      isloading.value = false;
    }
  }

  Future<void> pickAndUploadImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        final file = File(image.path);
        final fileName =
            'hr_${data['id']}_${DateTime.now().millisecondsSinceEpoch}.${image.path.split('.').last}';
        await hrdata.updateProfileImage(fileName, file, data['id'] ?? 0);
        await getdata();
        AppSnack.success('تم التحميل بنجاح', 'تم تحديث الصورة بنجاح');
      }
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء تحميل الصورة');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      // It's better to have this call inside your AuthRepository
      await Supabase.instance.client.auth.signOut();
      await myservices.sharedPref.clear();
      // Clear session flag
      await myservices.sharedPref.setBool('IsLogin', false);
      await myservices.sharedPref.setBool('onBoardingSeen', true);

      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      showErrorDialog(context, "حدث خطأ أثناء تسجيل الخروج: ${e.toString()}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('here');
    getdata();
  }
}
