import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class PaySalaryButton extends StatelessWidget {
  const PaySalaryButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(
          "تسليم الراتب",
          style: cairoStyle(fontSize: 11, fontcolor: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
