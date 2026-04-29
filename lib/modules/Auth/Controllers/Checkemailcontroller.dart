import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/modules/Auth/reposity/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Checkemailcontroller extends GetxController {
  AuthRepository repo = Get.find();
  Myservices myservices = Get.find();
  late TextEditingController emailController;

  bool isLoading = false;

  Future<void> resetPassword(BuildContext context, String email) async {
    if (email.isEmpty) {
      showErrorDialog(context, "من فضلك أدخل البريد الإلكتروني");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      showErrorDialog(context, "صيغة البريد الإلكتروني غير صحيحة");
      return;
    }

    try {
      isLoading = true;
      update();
      myservices.sharedPref.setString("emailSent", email);
      await repo.Forgetpassword(email);

      showErrorDialog(
        context,
        "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني",
        false,
      );
    } on AuthException catch (e) {
      // أخطاء Supabase Auth
      String message = "حدث خطأ غير متوقع";

      switch (e.message) {
        case "User not found":
          message = "هذا البريد غير مسجل لدينا";
          break;

        case "Email not confirmed":
          message = "البريد الإلكتروني لم يتم تأكيده بعد";
          break;

        default:
          print(e.message);
          message = "خطأ: ${e.message}";
      }

      showErrorDialog(context, message);
    } catch (e) {
      print(e.toString());
      showErrorDialog(context, "حدث خطأ غير متوقع");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
