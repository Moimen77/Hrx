import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class AppSnack {
  static void success(String title, String message) {
    _showSnack(
      title: title,
      message: message,
      color: const Color(0xff197fe6),
      icon: Icons.check_circle,
    );
  }

  static void error(String title, String message) {
    _showSnack(
      title: title,
      message: message,
      color: Colors.red,
      icon: Icons.error,
    );
  }

  static void warning(String title, String message) {
    _showSnack(
      title: title,
      message: message,
      color: Colors.orange,
      icon: Icons.warning,
    );
  }

  static void info(String title, String message) {
    _showSnack(
      title: title,
      message: message,
      color: Colors.grey.shade800,
      icon: Icons.info,
    );
  }

  static void _showSnack({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    final context = Get.overlayContext;

    if (context == null) {
      debugPrint("Overlay context is null");
      return;
    }

    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      colorText: Colors.white,
      titleText: Text(
        title,
        style: cairoStyle(fontSize: 18, fontcolor: Colors.white),
      ),
      messageText: Text(
        message,
        style: cairoStyle(fontSize: 16, fontcolor: Colors.white),
      ),
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      icon: Icon(icon, color: Colors.white),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
