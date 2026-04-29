import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/controller/ShiftController.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/widget/ShiftsView/ShiftsViewForm.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ShiftScreen extends GetView<ShiftController> {
  const ShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "إدارة الشيفتات"),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          return controller.isLoading.value
              ? Loadingcircular()
              : ShiftsViewForm();
        }),
      ),
    );
  }
}
