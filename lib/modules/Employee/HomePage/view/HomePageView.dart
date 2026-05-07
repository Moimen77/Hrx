import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/HomePage/widget/HomePageForm.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class HomepageView extends GetView<Homepagecontroller> {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.networkController.isConnected.value) {
          return NoInternetWidget(
            onPressed: () async {
              await controller.loadall();
            },
          );
        }
        if (controller.isloading.value) {
          return Loadingcircular();
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.loadall();
          },
          child: HomepageForm(),
        );
      }),
    );
  }
}
