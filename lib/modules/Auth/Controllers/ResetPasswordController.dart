// ignore_for_file: unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  late String recoveryToken;

  /// يستقبل الروابط اللي راجعة من Supabase
  void handleDeepLink(String link) {
    Uri uri = Uri.parse(link);

    // أهم شيء هنا — Supabase بترجع token داخل الـ fragment
    String? token = uri.fragment.split("=").last;

    if (token == null || token.isEmpty) {
      Get.snackbar("خطأ", "لا يوجد رمز صالح");
      return;
    }

    recoveryToken = token;
    update();
  }

  /// تغيير الباسورد بعد ما ناخد الـ token
  Future<void> changePassword(String newPassword) async {
    try {
      isLoading.value = true;

      await Supabase.instance.client.auth.setSession(recoveryToken);
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      Get.snackbar("تم", "تم تغيير كلمة المرور بنجاح!");
      Get.offAllNamed("/login");
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
