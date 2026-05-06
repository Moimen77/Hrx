import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/AddBranchDetailsController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddBranchDetailsScreen extends GetView<AddBranchDetailsController> {
  const AddBranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'إضافة فرع جديد'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'تفاصيل الفرع الجديد',
                        style: cairoStyle(
                          fontSize: 22.spAdaptive(context),
                          fontweight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(30),
                      Textfieldapp(
                        controller: controller.nameController,
                        hint: 'اسم الفرع',
                        suffixIcon: const Icon(
                          Icons.store_mall_directory_outlined,
                        ),
                      ),
                      const Gap(20),
                      Textfieldapp(
                        controller: controller.addressController,
                        hint: 'عنوان الفرع',
                        suffixIcon: const Icon(Icons.location_on_outlined),
                      ),
                      const Gap(40),
                      Obx(
                        () => Buttonapp(
                          text: 'إضافة الفرع',
                          OnTap: () {
                            controller.onAddBranch(context);
                          },
                          width: Get.width * 0.85,
                          isloading: controller.isAddingBranch.value,
                          Loadingtext: 'جاري إضافة الفرع...',
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
    );
  }
}
