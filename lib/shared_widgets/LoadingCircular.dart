// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';

class Loadingcircular extends StatelessWidget {
  Loadingcircular({super.key, this.color});
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: color ?? Appcolors.primarycolor,
        ),
      ),
    );
  }
}
