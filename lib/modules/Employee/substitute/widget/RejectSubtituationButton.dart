import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class RejectSubtituationButton extends StatelessWidget {
  const RejectSubtituationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Get.snackbar('رفض', 'تم تجاهل الطلب.');
      },
      icon: const Icon(Icons.close),
      label: Text('رفض', style: cairoStyle()),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
