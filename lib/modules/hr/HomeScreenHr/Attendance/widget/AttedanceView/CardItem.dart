import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';

import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Carditem extends StatelessWidget {
  const Carditem({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Circle
          Get.width > 732
              ? SizedBox.shrink()
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 20.spAdaptive(context),
                      ),
                    ),

                    const SizedBox(width: 12),
                  ],
                ),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: cairoStyle(
                    fontSize: Responsive.isDesktop(context)
                        ? 10.spAdaptive(context)
                        : 13.spAdaptive(context),
                    fontcolor: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: cairoStyle(
                    fontSize: Responsive.isDesktop(context)
                        ? 15.spAdaptive(context)
                        : 17.spAdaptive(context),
                    fontweight: FontWeight.bold,
                    fontcolor: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
