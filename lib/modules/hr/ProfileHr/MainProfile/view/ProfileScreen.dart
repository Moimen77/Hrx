import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/ProfileScreenForm.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';

class ProfileScreen extends GetView<Hrcontroller> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.isloading.value ? Loadingcircular() : ProfileScreenForm(),
    );
  }
}
