import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/function/AlertExitApp.dart';
import 'package:hrx/modules/Auth/widget/LoginCard.dart';
import 'package:hrx/modules/Auth/widget/imageLogin.dart';
import 'package:hrx/shared_widgets/titletext.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showExitDialog(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (Responsive.isDesktop(context)) {
                return _webLayout(context);
              } else if (Responsive.isTablet(context)) {
                return _tabletLayout();
              } else {
                return _mobileLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(Get.context!).size.height,
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Imagelogin(),
              Titletext(title: 'نظام إدارة الموارد البشرية', size: 18.sp),
              Gap(10.h),
              Logincard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabletLayout() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600.w),
          child: Column(
            children: [
              Imagelogin(),
              Titletext(title: 'نظام إدارة الموارد البشرية', size: 18.sp),
              Gap(20.h),
              Logincard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _webLayout(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1100.w),
          child: Row(
            children: [
              Expanded(child: Imagelogin()),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Titletext(
                        title: 'نظام إدارة الموارد البشرية',
                        size: 21.sp,
                      ),
                      Gap(30),
                      Logincard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
