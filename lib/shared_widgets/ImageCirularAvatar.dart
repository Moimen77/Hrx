// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/appColors.dart';

class Imagecirularavatar extends StatelessWidget {
  Imagecirularavatar({super.key, this.imageUrl, required this.icon});
  final IconData icon;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Appcolors.primarycolor.withOpacity(0.1),
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Icon(icon, size: 35, color: Appcolors.primarycolor)
          : null,
    );
  }
}
