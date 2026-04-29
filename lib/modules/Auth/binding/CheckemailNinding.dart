import 'package:get/get.dart';
import 'package:hrx/modules/Auth/Controllers/Checkemailcontroller.dart';

class CheckemailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Checkemailcontroller());
  }
}
