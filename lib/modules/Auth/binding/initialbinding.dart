import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController());
  }
}
