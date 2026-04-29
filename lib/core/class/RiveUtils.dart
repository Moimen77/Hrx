import 'package:rive/rive.dart';

class riveUtils {
  static StateMachineController getRiveController(
    Artboard artboard,
    String stateMachineName,
  ) {
    StateMachineController? controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );
    if (controller != null) {
      artboard.addController(controller);
    }
    return controller!;
  }
}
