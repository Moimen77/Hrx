import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Reseetpasscontroller extends GetxController {
  final Myservices services = Get.find();

  late TextEditingController password;
  bool isLoading = false;
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> resetPassword(BuildContext context) async {
    final newPassword = password.text.trim();

    if (newPassword.length < 6) {
      Get.snackbar('خطأ', 'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      return;
    }

    try {
      isLoading = true;
      update();

      final session = Supabase.instance.client.auth.currentSession;

      // 🔥 لازم يكون فيه session من deep link
      if (session == null) {
        Get.snackbar('خطأ', 'الرابط منتهي أو غير صالح');
        return;
      }

      // ✅ تحديث الباسورد مباشرة
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      showErrorDialog(context, 'تم تحديث كلمة المرور بنجاح', false);

      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      print(e.toString());
      Get.snackbar('خطأ', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    password.dispose();
    super.onClose();
  }
}
