import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/AddBranchDetailsController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddBranchDetailsScreen extends GetView<AddBranchDetailsController> {
  const AddBranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = cairoStyle(
      fontSize: 13,
      fontweight: FontWeight.w600,
      fontcolor: Colors.black54,
    );

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
                          fontSize: 22,
                          fontweight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(30),
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          labelText: 'اسم الفرع',
                          hintStyle: style,
                          labelStyle: style,
                          hintText: 'مثال: فرع القاهرة الجديدة',
                          prefixIcon: Icon(Icons.store_mall_directory_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال اسم الفرع';
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      TextFormField(
                        controller: controller.addressController,
                        decoration: InputDecoration(
                          labelText: 'عنوان الفرع',
                          labelStyle: style,
                          hintStyle: style,
                          hintText: 'مثال: 123 شارع التسعين، التجمع الخامس',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال عنوان الفرع';
                          }
                          return null;
                        },
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
