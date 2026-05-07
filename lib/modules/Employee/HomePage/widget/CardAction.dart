import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class CardAction extends StatelessWidget {
  const CardAction({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(13.spAdaptive(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: BoxBorder.all(color: Colors.black12),
            ),
            child: Icon(
              icon,
              color: const Color(0xff2e6ee5),
              size: 30.spAdaptive(context),
            ),
          ),
          const Gap(6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: cairoStyle(
              fontSize: 12.spAdaptive(context),
              fontweight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
