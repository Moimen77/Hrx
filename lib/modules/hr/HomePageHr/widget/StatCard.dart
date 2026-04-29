import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final desktop = Responsive.isDesktop(context);
    final tablet = Responsive.isTablet(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          desktop
              ? 10
              : tablet
              ? 16
              : 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(desktop ? 24 : 20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    desktop
                        ? 7
                        : tablet
                        ? 14
                        : 12,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 17.spAdaptive(context)),
                ),

                Text(
                  value,
                  style: cairoStyle(
                    fontSize: desktop
                        ? 10.sp
                        : tablet
                        ? 18.sp
                        : 16.sp,
                    fontweight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: desktop ? 10.h : 15.h),

            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: cairoStyle(
                fontSize: desktop
                    ? 9.sp
                    : tablet
                    ? 14.sp
                    : 13.sp,
                fontweight: FontWeight.w600,
                fontcolor: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
