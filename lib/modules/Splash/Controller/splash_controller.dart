import 'package:get/get.dart';
import 'package:hrx/modules/Auth/Controllers/Deeplinkingcontroller.dart';

class SplashController extends GetxController {
  final Deeplinkingcontroller deepLinking = Get.put(Deeplinkingcontroller());
  @override
  void onInit() {
    super.onInit();
    // نفحص الرابط فقط مرة واحدة عند البداية
    deepLinking.initAppLinks();
  }
}
