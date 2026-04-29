import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveController.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceCard.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AdvanceArchiveView extends GetView<AdvanceArchiveController> {
  const AdvanceArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'سجل السلف'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (!controller.networkController.isConnected.value) {
            return NoInternetWidget(
              onPressed: () async {
                await controller.fetchUserAdvances();
                await Get.find<Homepagecontroller>().loadall();
              },
            );
          }
          if (controller.isLoading.value) {
            return Loadingcircular();
          }
          if (controller.advances.isEmpty) {
            return Center(
              child: Text('لا توجد سلف سابقة', style: cairoStyle()),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchUserAdvances();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.advances.length,
              itemBuilder: (context, index) =>
                  AdvanceCard(advance: controller.advances[index]),
            ),
          );
        }),
      ),
    );
  }
}
