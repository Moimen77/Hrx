import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/ScreenSize.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/HomeScreenController.dart';
import 'package:hrx/shared_widgets/sideBar/SideMenueTitle.dart';

class SideMenueBar extends GetView<Homescreencontroller> {
  const SideMenueBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: width * 0.6,
          color: const Color(0xff17203A),
          child: Column(
            children: [
              /// 🔹 Header ثابت فوق
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'مرحبا ف نظام \nإدارة الموارد البشرية',
                  textAlign: TextAlign.center,
                  style: cairoStyle(
                    fontcolor: Colors.white,
                    fontSize: 23,
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...controller.menus.map(
                                  (e) => SideMenueTitle(
                                    riveModel: e,
                                    isActivie:
                                        controller.selectedMenu.value == e,
                                    onTap: () => controller.onMenuTap(e),
                                    onInit: (artboard) =>
                                        controller.onRiveInit(artboard, e),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
