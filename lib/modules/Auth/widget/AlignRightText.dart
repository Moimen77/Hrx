import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

// ignore: must_be_immutable
class Alignrighttext extends StatelessWidget {
  Alignrighttext({super.key, required this.text, this.alignment});
  final String text;
  TextAlign? alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        textAlign: alignment ?? TextAlign.right,
        text,
        style: cairoStyle(
          fontSize: 12.spAdaptive(context),
          fontcolor: Colors.black87,
          fontweight: FontWeight.w600,
        ),
      ),
    );
  }
}
