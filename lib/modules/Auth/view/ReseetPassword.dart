import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Auth/Controllers/ReseetPassController.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ResetPasswordView extends GetView<Reseetpasscontroller> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: ('إعادة تعيين كلمة المرور')),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.lock_reset_rounded,
                            size: 100,
                            color: Colors.blueAccent,
                          ),

                          const SizedBox(height: 30),

                          Text(
                            'إنشاء كلمة مرور جديدة',
                            style: cairoStyle(
                              fontSize: 22,
                              fontweight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'يرجى إدخال كلمة المرور الجديدة الخاصة بك أدناه لتأمين حسابك.',
                            style: cairoStyle(
                              fontSize: 14,
                              fontcolor: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 40),

                          //  Password Field
                          GetBuilder<Reseetpasscontroller>(
                            builder: (_) => TextField(
                              controller: controller.password,
                              obscureText: !controller.isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'كلمة المرور الجديدة',
                                labelStyle: cairoStyle(fontcolor: Colors.grey),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // 🔘 Button
                          GetBuilder<Reseetpasscontroller>(
                            builder: (_) => SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                onPressed: controller.isLoading
                                    ? null
                                    : () => controller.resetPassword(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: controller.isLoading
                                    ? Loadingcircular(color: Colors.white)
                                    : Text(
                                        "تحديث كلمة المرور",
                                        style: cairoStyle(
                                          fontSize: 16,
                                          fontweight: FontWeight.bold,
                                          fontcolor: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
