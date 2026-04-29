import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:flutter/foundation.dart'; // عشان kIsWeb

class Deeplinkingcontroller extends GetxController {
  final AppLinks _appLinks = AppLinks();
  bool _handledInitialLink = false;
  StreamSubscription? _sub;
  void initAppLinks() async {
    final prefs = Get.find<Myservices>().sharedPref;

    await Future.delayed(const Duration(seconds: 2));

    //  لو Web -> متستخدمش app_links
    if (kIsWeb) {
      _goNext(prefs);
      return;
    }

    //  Mobile فقط
    _sub = _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        if (uri == null) return;
        _handleUri(uri, prefs);
      },
      onError: (err) {
        print('DeepLink Error: $err');
      },
    );

    try {
      final initialUri = await _appLinks.getInitialLink();

      if (initialUri != null && !_handledInitialLink) {
        _handledInitialLink = true;
        _handleUri(initialUri, prefs);
        return;
      }

      if (!_handledInitialLink) {
        _goNext(prefs);
      }
    } catch (e) {
      print('Failed to get initial link: $e');
      _goNext(prefs); // fallback مهم
    }
  }

  void _handleUri(Uri uri, dynamic prefs) {
    if (uri.scheme == 'myapp' &&
        uri.host == 'reset-password' &&
        !prefs.getBool("IsLogin")) {
      Get.offAllNamed(AppRoutes.resetPassword);
      return;
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }

  void _goNext(dynamic prefs) {
    bool sawOnboarding = prefs.getBool("onBoardingSeen") ?? false;

    if (sawOnboarding) {
      if (prefs.getBool('IsLogin') ?? false) {
        if (prefs.getBool('IsActive') == false) {
          Get.offAllNamed(AppRoutes.inactiveAccount);
        } else {
          if (prefs.getBool('IsHr') ?? false) {
            Get.offAllNamed(AppRoutes.home);
          } else {
            Get.offAllNamed(AppRoutes.empHome);
          }
        }
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
