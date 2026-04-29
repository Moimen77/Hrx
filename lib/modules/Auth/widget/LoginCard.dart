import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Auth/Controllers/auth_controller.dart';
import 'package:hrx/modules/Auth/widget/AlignRightText.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';
import 'package:hrx/shared_widgets/titletext.dart';

class Logincard extends GetView<AuthController> {
  const Logincard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500.w),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Titletext(
              title: 'أهلا بعودتك',
              size: !Responsive.isDesktop(context) ? 18.sp : 14.sp,
            ),
            Gap(Get.height * 0.022),
            Alignrighttext(text: "اسم المستخدم أو البريد الإلكتروني"),
            Gap(3.h),
            Textfieldapp(
              controller: controller.email,
              hint: "أدخل اسم المستخدم أو البريد الإلكتروني",
              suffixIcon: Icon(
                Icons.person_outline,
                size: 17.spAdaptive(context),
              ),
            ),
            Gap(10.h),
            Alignrighttext(text: 'كلمة المرور'),
            Gap(3.h),
            Obx(
              () => Textfieldapp(
                obscureText: controller.isPasswordHidden.value,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.password,
                hint: 'أدخل كلمة المرور',
                suffixIcon: Icon(
                  Icons.lock_outline,
                  size: 17.spAdaptive(context),
                ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    controller.isPasswordHidden.value =
                        !controller.isPasswordHidden.value;
                  },
                  child: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 17.spAdaptive(context),
                  ),
                ),
              ),
            ),
            Gap(15),
            GetBuilder<AuthController>(
              builder: (controll) => Buttonapp(
                OnTap: () async {
                  await controller.login(
                    controller.email.text,
                    controller.password.text,
                    context,
                  );
                },
                text: 'تسجيل الدخول',
                width: double.infinity,
                isloading: controll.isLoading,
                Loadingtext: 'جارى التحميل...',
              ),
            ),
            Gap(12.h),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.sendemail);
              },
              child: Text(
                "نسيت كلمة المرور؟",
                style: cairoStyle(
                  fontcolor: Appcolors.primarycolor,
                  fontSize: !Responsive.isDesktop(context) ? 16.sp : 8.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
