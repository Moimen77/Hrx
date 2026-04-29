// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Auth/Controllers/Checkemailcontroller.dart';
import 'package:hrx/modules/Auth/widget/AlignRightText.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';

class ForgetpasseordPage extends GetView<Checkemailcontroller> {
  const ForgetpasseordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 🔙 Header
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                          const Spacer(),
                          Text(
                            'استعادة كلمة المرور',
                            style: cairoStyle(
                              fontcolor: Colors.grey.shade800,
                              fontSize: 20,
                              fontweight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // 🧠 Title
                      Text(
                        'هل نسيت كلمة المرور؟',
                        style: cairoStyle(
                          fontcolor: Colors.black,
                          fontSize: 20,
                          fontweight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'لا تقلق يحدث ذلك. أدخل البريد الألكتروني\nلأستعادة حسابك',
                        textAlign: TextAlign.center,
                        style: cairoStyle(
                          fontcolor: Colors.black,
                          fontSize: 16,
                          fontweight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 📦 Card
                      Card(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Alignrighttext(text: "البريد الإلكتروني"),
                              const SizedBox(height: 5),

                              Textfieldapp(
                                controller: controller.emailController,
                                hint: "أدخل البريد الإلكتروني",
                                suffixIcon: const Icon(Icons.person_outline),
                              ),

                              const SizedBox(height: 12),

                              Alignrighttext(
                                text:
                                    "سيتم إرسال رابط لإعادة تعيين كلمة المرور",
                              ),

                              const SizedBox(height: 25),

                              GetBuilder<Checkemailcontroller>(
                                builder: (controller) => Buttonapp(
                                  OnTap: () async {
                                    await controller.resetPassword(
                                      context,
                                      controller.emailController.text,
                                    );
                                  },
                                  width: double.infinity,
                                  isloading: controller.isLoading,
                                  text: 'إرسال الرابط',
                                  Loadingtext: 'جارٍ الإرسال...',
                                ),
                              ),
                            ],
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
    );
  }
}
