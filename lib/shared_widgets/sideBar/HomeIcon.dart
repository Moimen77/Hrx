import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomeIcon extends StatefulWidget {
  const HomeIcon({super.key});

  @override
  State<HomeIcon> createState() => _HomeIconState();
}

class _HomeIconState extends State<HomeIcon> {
  SMIBool? active;

  void _onInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'HOME_interactivity',
    );

    if (controller != null) {
      artboard.addController(controller);
      active = controller.findSMI('active');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        active?.value = !(active?.value ?? false);
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: RiveAnimation.asset(
          'resources/assets/rive/1298-2487-animated-icon-set-1-color.riv',
          artboard: 'HOME',
          onInit: _onInit,
        ),
      ),
    );
  }
}
