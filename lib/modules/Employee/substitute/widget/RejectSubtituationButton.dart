import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class RejectSubtituationButton extends StatelessWidget {
  const RejectSubtituationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Get.snackbar('رفض', 'تم تجاهل الطلب.');
      },
      icon: Icon(Icons.close, size: 18.spAdaptive(context)),
      label: Text(
        'رفض',
        style: cairoStyle(fontSize: 14.spAdaptive(context)),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        side: const BorderSide(color: Colors.red),
        padding: EdgeInsets.symmetric(
          horizontal: 14.spAdaptive(context),
          vertical: 12.spAdaptive(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.spAdaptive(context)),
        ),
      ),
    );
  }
}
