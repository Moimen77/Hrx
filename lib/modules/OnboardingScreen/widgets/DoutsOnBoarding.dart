import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart' show Appcolors;

class Doutsonboarding extends StatelessWidget {
  const Doutsonboarding({super.key, required this.isactive});
  final bool isactive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isactive ? 20 : 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isactive ? Appcolors.primarycolor : Colors.grey,
      ),
      duration: Duration(milliseconds: 300),
    );
  }
}
