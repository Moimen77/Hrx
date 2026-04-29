import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class AddAllownaceButton extends StatelessWidget {
  const AddAllownaceButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed!,
        child: Text(
          "إضافة بدل",
          style: cairoStyle(fontSize: 12, fontcolor: Colors.white),
        ),
      ),
    );
  }
}
