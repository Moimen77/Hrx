// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Buttonapp extends StatelessWidget {
  const Buttonapp({
    super.key,
    required this.OnTap,
    required this.text,
    required this.Loadingtext,
    required this.isloading,
    this.width,
  });

  final void Function() OnTap;
  final String text;
  final String Loadingtext;
  final bool isloading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * 0.9,

      child: ElevatedButton.icon(
        onPressed: isloading ? null : OnTap,
        icon: isloading
            ? SizedBox(
                width: 20.spAdaptive(context),
                height: 20.spAdaptive(context),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Icon(
                Icons.save_alt_outlined,
                size: 20.spAdaptive(context),
                color: Colors.white,
              ),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            isloading ? Loadingtext : text,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: cairoStyle(
              fontSize: 15.spAdaptive(context),
              fontweight: FontWeight.bold,
              fontcolor: Colors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.primarycolor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
