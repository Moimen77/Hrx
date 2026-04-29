import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class NoInternetWidget extends GetView<NetworkController> {
  const NoInternetWidget({super.key, required this.onPressed});
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(
          () => ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Appcolors.primarycolor.withValues(alpha: 0.10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Appcolors.primarycolor.withValues(alpha: 0.12),
                          Appcolors.primarycolor.withValues(alpha: 0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.wifi_off_rounded,
                      size: 42,
                      color: Appcolors.primarycolor,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "لا يوجد اتصال بالإنترنت",
                    textAlign: TextAlign.center,
                    style: cairoStyle(
                      fontSize: 22,
                      fontweight: FontWeight.w700,
                      fontcolor: const Color(0xFF1D2939),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "تحقق من الشبكة أو الواي فاي، ثم أعد المحاولة لاستكمال تحميل البيانات.",
                    textAlign: TextAlign.center,
                    style: cairoStyle(
                      fontSize: 14,
                      height: 1.6,
                      fontcolor: const Color(0xFF667085),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Appcolors.warning,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            controller.isChecking.value
                                ? "جارٍ فحص الاتصال الآن..."
                                : "التطبيق ينتظر عودة الاتصال للمتابعة.",
                            style: cairoStyle(
                              fontSize: 13,
                              fontweight: FontWeight.w600,
                              fontcolor: const Color(0xFF475467),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isChecking.value
                          ? null
                          : () async {
                              await controller.checkInternet();
                              if (controller.isConnected.value) {
                                await onPressed();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.primarycolor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Appcolors.primarycolor
                            .withValues(alpha: 0.65),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        textStyle: cairoStyle(
                          fontSize: 15,
                          fontweight: FontWeight.w700,
                          fontcolor: Colors.white,
                        ),
                      ),
                      child: controller.isChecking.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "جارٍ إعادة المحاولة",
                                  style: cairoStyle(
                                    fontSize: 15,
                                    fontweight: FontWeight.w700,
                                    fontcolor: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "إعادة المحاولة",
                              style: cairoStyle(
                                fontSize: 15,
                                fontweight: FontWeight.w700,
                                fontcolor: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
