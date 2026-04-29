import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Loans/loanController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class RequestAdvanceView extends GetView<RequestAdvanceController> {
  const RequestAdvanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'طلب سلفة مالية'),
      body: Obx(
        () => !controller.networkController.isConnected.value
            ? NoInternetWidget(
                onPressed: () async {
                  await controller.retryConnection();
                },
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Text(
                            'قم بإدخال بيانات السلفة المطلوبة',
                            style: cairoStyle(
                              fontSize: 16,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                          const Gap(20),
                          Text(
                            'المبلغ المطلوب',
                            style: cairoStyle(fontSize: 14),
                          ),
                          const Gap(8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Obx(
                                  () => Text(
                                    '${controller.currentSliderValue.value.toInt()} ج.م',
                                    style: cairoStyle(
                                      fontSize: 20,
                                      fontweight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Slider(
                                    value: controller.currentSliderValue.value,
                                    min: 0,
                                    max: 5000,
                                    divisions: 50,
                                    label: controller.currentSliderValue.value
                                        .toString(),
                                    onChanged: (value) {
                                      controller.currentSliderValue.value =
                                          value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          Text(
                            'ملاحظات (سبب السلفة)',
                            style: cairoStyle(fontSize: 14),
                          ),
                          const Gap(8),
                          TextFormField(
                            controller: controller.noteController,
                            maxLines: 3,
                            style: cairoStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'أكتب أي تفاصيل إضافية هنا...',
                              hintStyle: cairoStyle(
                                fontSize: 12,
                                fontcolor: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Gap(40),
                          Obx(
                            () => Buttonapp(
                              OnTap: () {
                                controller.submitRequest(context);
                              },
                              text: 'إرسال الطلب',
                              Loadingtext: 'جاري الإرسال...',
                              isloading: controller.isLoading.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
