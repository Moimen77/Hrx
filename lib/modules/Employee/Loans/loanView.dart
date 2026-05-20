import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Loans/loanController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class RequestAdvanceView extends GetView<RequestAdvanceController> {
  const RequestAdvanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'طلب سلفة مالية'),
      body: Obx(
        () => !controller.networkController.isConnected.value
            ? NoInternetWidget(
                onPressed: () async {
                  await controller.retryConnection();
                },
              )
            : Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop
                        ? 950
                        : isTablet
                        ? 720
                        : double.infinity,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      isDesktop
                          ? 24.spAdaptive(context)
                          : 16.spAdaptive(context),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Form(
                        key: controller.formKey,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(20.spAdaptive(context)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                16.spAdaptive(context),
                              ),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'قم بإدخال بيانات السلفة المطلوبة',
                                  style: cairoStyle(
                                    fontSize: 16.spAdaptive(context),
                                    fontweight: FontWeight.bold,
                                  ),
                                ),
                                Gap(20.spAdaptive(context)),
                                Text(
                                  'المبلغ المطلوب',
                                  style: cairoStyle(
                                    fontSize: 14.spAdaptive(context),
                                  ),
                                ),
                                Gap(8.spAdaptive(context)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.spAdaptive(context),
                                    vertical: 20.spAdaptive(context),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(
                                      12.spAdaptive(context),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => Text(
                                          '${controller.currentSliderValue.value.toInt()} ج.م',
                                          style: cairoStyle(
                                            fontSize: 20.spAdaptive(context),
                                            fontweight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Slider(
                                          value: controller
                                              .currentSliderValue
                                              .value,
                                          min: 0,
                                          max: 5000,
                                          divisions: 50,
                                          label: controller
                                              .currentSliderValue
                                              .value
                                              .toString(),
                                          onChanged: (value) {
                                            controller
                                                    .currentSliderValue
                                                    .value =
                                                value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(20.spAdaptive(context)),
                                Text(
                                  'ملاحظات (سبب السلفة)',
                                  style: cairoStyle(
                                    fontSize: 14.spAdaptive(context),
                                  ),
                                ),
                                Gap(8.spAdaptive(context)),
                                TextFormField(
                                  controller: controller.noteController,
                                  maxLines: 3,
                                  style: cairoStyle(
                                    fontSize: 14.spAdaptive(context),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'أكتب أي تفاصيل إضافية هنا...',
                                    hintStyle: cairoStyle(
                                      fontSize: 12.spAdaptive(context),
                                      fontcolor: Colors.grey,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14.spAdaptive(context),
                                      vertical: 14.spAdaptive(context),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        12.spAdaptive(context),
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(40.spAdaptive(context)),
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
                ),
              ),
      ),
    );
  }
}
