import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

mixin NetworkAwareMixin on GetxController {
  NetworkController get networkController => Get.find<NetworkController>();

  Future<bool> ensureInternetConnection({bool showMessage = true}) async {
    if (kIsWeb) {
      try {
        return true;
      } catch (e) {
        print('No internet connection');
        print('Error: $e');
      }

      if (showMessage) {
        AppSnack.error('خطأ', 'لا يوجد اتصال بالإنترنت');
      }

      return false;
    }

    //  موبايل (Android / iOS)
    final networkController = Get.find<NetworkController>();

    await networkController.checkInternet();

    if (networkController.isConnected.value) {
      return true;
    }

    if (showMessage) {
      AppSnack.error('خطأ', 'لا يوجد اتصال بالإنترنت');
    }

    return false;
  }
}
