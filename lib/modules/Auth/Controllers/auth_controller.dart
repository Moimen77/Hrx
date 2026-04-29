// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/Auth/reposity/auth_repository.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class AuthController extends GetxController with NetworkAwareMixin {
  final AuthRepository repo;
  AuthController(this.repo);
  Myservices myservices = Get.find();
  RxList<EmployeeModel> Employees = <EmployeeModel>[].obs;
  EmployeeModel? get Employee => Employees.first;
  late TextEditingController email;
  late TextEditingController password;

  bool isLoading = false;
  var isPasswordHidden = true.obs;

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      if (email.isEmpty) {
        showErrorDialog(context, "من فضلك أدخل البريد الإلكتروني");
        return;
      }

      if (!GetUtils.isEmail(email)) {
        showErrorDialog(context, "صيغة البريد الإلكتروني غير صحيحة");
        return;
      }

      if (password.isEmpty) {
        showErrorDialog(context, "من فضلك أدخل كلمة المرور");
        return;
      }

      isLoading = true;
      update();
      final hasInternet = await ensureInternetConnection();
      if (!hasInternet) {
        isLoading = false;
        return;
      }
      final user = await repo.login(email, password);

      if (user != null) {
        final isHr = await repo.isHr(email);
        if (isHr) {
          final isHrActive = await repo.isCurrentHrActive();

          if (!isHrActive) {
            isLoading = false;
            myservices.sharedPref.setBool('IsLogin', false);
            update();
            Get.offAllNamed(AppRoutes.inactiveAccount);
            return;
          }
          final username = await repo.getHrUserName();
          myservices.sharedPref.setBool('IsLogin', true);
          myservices.sharedPref.setBool('IsHr', true);
          myservices.sharedPref.setString('Username', username);
          myservices.sharedPref.setBool('IsActive', isHrActive);
          !kIsWeb ? FirebaseMessaging.instance.subscribeToTopic('hr') : null;
          Get.offAllNamed(AppRoutes.home);
        } else {
          myservices.sharedPref.setBool('IsLogin', true);
          Employees.value = await repo.GetProfileData();

          if (Employee != null && Employee!.status != 'Active') {
            myservices.sharedPref.setBool('IsActive', false);
            isLoading = false;
            update();
            Get.offAllNamed(AppRoutes.inactiveAccount);
            return;
          }

          myservices.sharedPref.setBool('IsActive', true);
          myservices.sharedPref.setBool('SeenOnboarding', true);
          myservices.sharedPref.setBool('IsHr', false);
          myservices.sharedPref.setString('id', Employee!.id.toString());
          myservices.sharedPref.setString('name', Employee!.name.toString());
          myservices.sharedPref.setBool('isManager', Employee!.isManger!);
          if (!kIsWeb) {
            FirebaseMessaging.instance.subscribeToTopic(
              Employee!.id.toString(),
            );
            FirebaseMessaging.instance.subscribeToTopic(
              'Dep${Employee!.departmentId}',
            );
            FirebaseMessaging.instance.subscribeToTopic('emps');
          }
          myservices.sharedPref.setString(
            'department_id',
            Employee!.departmentId.toString(),
          );
          Get.offAllNamed(AppRoutes.empHome);
        }
      } else {
        showErrorDialog(context, "بيانات تسجيل الدخول غير صحيحة");
      }
    } on AuthException catch (e) {
      // معالجة أخطاء Supabase
      String message = "حدث خطأ غير متوقع";

      switch (e.message) {
        case "Invalid login credentials":
          message = "كلمة المرور أو البريد الإلكتروني غير صحيحة";
          break;

        case "Email not confirmed":
          message = "البريد الإلكتروني لم يتم تأكيده بعد";
          break;

        case "User not found":
          message = "هذا المستخدم غير موجود";
          break;

        case "User disabled":
          message = "هذا الحساب معطّل";
          break;

        default:
          message = "خطأ: ${e.message}";
      }
      showErrorDialog(context, message);
    } catch (e) {
      showErrorDialog(context, "خطأ: ${e.toString()}");
    } finally {
      isLoading = false;
      update();
    }
  }

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

      await repo.Forgetpassword(email);

      showErrorDialog(
        context,
        "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني",
      );

      showErrorDialog(context, "حدث خطأ أثناء إرسال البريد، حاول لاحقًا");
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
          message = "خطأ: ${e.message}";
      }

      showErrorDialog(context, message);
    } catch (e) {
      showErrorDialog(context, "حدث خطأ غير متوقع");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
