import 'dart:io';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var isConnected = false.obs;
  var isChecking = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
  }

  Future<void> checkInternet() async {
    isChecking.value = true;

    try {
      final result = await InternetAddress.lookup('google.com');
      isConnected.value = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      isConnected.value = false;
    }

    isChecking.value = false;
  }
}
