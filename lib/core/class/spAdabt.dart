import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';

extension ResponsiveFont on num {
  double spAdaptive(BuildContext context) {
    final base = sp;

    if (Responsive.isDesktop(context)) {
      return base * 0.75; // أصغر للويب
    } else if (Responsive.isTablet(context)) {
      return base * 0.85; // متوسط
    } else {
      return base; // أكبر للموبايل
    }
  }
}
