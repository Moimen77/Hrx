// f:\Flutter\hrx\lib\modules\HomeScreen\Home\widget\HomeHeader.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/constant/ScreenSize.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';

class HomeHeader extends GetView<HomeController> {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isdesktop = Responsive.isDesktop(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: !isdesktop ? 20.sp : 10.sp,
        vertical: !isdesktop ? 5.sp : 2.sp,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مرحباً بك، ${controller.username} 👋",
                style: cairoStyle(
                  fontSize: isdesktop ? 10.sp : 18.sp,
                  fontweight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.005),
              Text(
                controller.currentDate,
                style: cairoStyle(
                  fontSize: isdesktop ? 8.sp : 14.sp,
                  fontweight: FontWeight.w500,
                  fontcolor: Colors.grey[600],
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: isdesktop ? 17.sp : 30.sp,
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.manage_accounts_sharp,
              size: isdesktop ? 17.sp : 30.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
