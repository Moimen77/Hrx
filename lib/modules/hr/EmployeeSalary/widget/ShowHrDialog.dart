import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class ShowHrDialog extends StatelessWidget {
  const ShowHrDialog({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed!,
        child: Text(
          "تقييم HR",
          style: cairoStyle(fontSize: 12, fontcolor: Colors.white),
        ),
      ),
    );
  }
}
