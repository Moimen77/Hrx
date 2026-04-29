import 'package:flutter/material.dart';
import 'package:hrx/core/constant/ScreenSize.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/RiveModels.dart';
import 'package:rive/rive.dart' show Artboard, RiveAnimation;

class SideMenueTitle extends StatelessWidget {
  const SideMenueTitle({
    super.key,
    required this.riveModel,
    required this.onTap,
    required this.onInit,
    required this.isActivie,
  });
  final riveModels riveModel;
  final VoidCallback onTap;
  final ValueChanged<Artboard> onInit;
  final bool isActivie;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 10),
            child: Divider(color: Colors.white24, height: 1),
          ),
          Stack(
            children: [
              AnimatedPositioned(
                width: isActivie ? width * 0.6 : 0,
                height: 56,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff6792ff),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              ListTile(
                onTap: onTap,
                leading: SizedBox(
                  width: 40,
                  height: 40,
                  child: riveModel.isRive
                      ? RiveAnimation.asset(
                          riveModel.src,
                          artboard: riveModel.artboard,
                          onInit: onInit,
                        )
                      : Image.asset(riveModel.src),
                ),
                title: Text(
                  riveModel.title,
                  style: cairoStyle(
                    fontcolor: Colors.white,
                    fontSize: 16,
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
