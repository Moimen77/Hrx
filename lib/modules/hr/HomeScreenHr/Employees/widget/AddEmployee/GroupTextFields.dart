import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/Valid.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddEmployeeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/buildTextField.dart';

class Grouptextfields extends StatelessWidget {
  Grouptextfields({super.key});

  final AddEmployeeController controller = Get.find<AddEmployeeController>();

  @override
  Widget build(BuildContext context) {
    final isEditMode = controller.mode == EmployeeViewMode.edit;

    return Column(
      children: [
        buildTextField(
          controller: controller.nameController,
          label: "اسم الموظف",
          icon: Icons.person_outline,
          validator: (val) {
            validstring(val!, 5, 30, "Name");
            return null;
          },
        ),
        const Gap(16),
        if (!isEditMode)
          buildTextField(
            controller: controller.emailController,
            label: "البريد الإلكتروني",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              validstring(val!, 5, 30, "Name");
              return null;
            },
          ),
        if (!isEditMode) const Gap(16),
        if (!isEditMode)
          buildTextField(
            controller: controller.passwordController,
            label: "كلمة المرور",
            icon: Icons.lock_outline,
            validator: (val) {
              validstring(val!, 5, 30, "password");
              return null;
            },
          ),
        if (!isEditMode) const Gap(16),
        buildTextField(
          controller: controller.phoneController,
          label: "رقم الهاتف",
          icon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
          validator: (val) {
            validstring(val!, 10, 12, "phone");
            return null;
          },
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: buildTextField(
                controller: controller.qualificationController,
                label: "المؤهل",
                icon: Icons.cast_for_education,
                validator: (val) {
                  validstring(val!, 5, 30, "qualification");
                  return null;
                },
              ),
            ),
            const Gap(5),
            Expanded(
              child: buildTextField(
                controller: controller.seniorityController,
                label: "الخبرة",
                icon: Icons.work_outline,
                validator: (val) {
                  validstring(val!, 1, 2, "number");
                  return null;
                },
              ),
            ),
          ],
        ),
        const Gap(16),
        Obx(
          () => Dropdownaddemployee(
            value: controller.employeeType.value,
            onChanged: (v) {
              controller.employeeType.value = v!;
            },
            items: [
              DropdownMenuItem(
                value: 'full_time',
                child: Text("شيفت كامل", style: cairoStyle()),
              ),
              DropdownMenuItem(
                value: 'half_time',
                child: Text("نصف شيفت", style: cairoStyle()),
              ),
              DropdownMenuItem(
                value: 'shifts',
                child: Text("شفتات", style: cairoStyle()),
              ),
              DropdownMenuItem(
                value: 'marketing',
                child: Text("تسويق", style: cairoStyle()),
              ),
            ],
            title: 'حالة التوظيف',
            icon: Icons.person_outline_outlined,
          ),
        ),
        const Gap(16),
        Obx(
          () => controller.employeeType.value == 'shifts'
              ? Column(
                  children: [
                    buildTextField(
                      controller: controller.shiftPriceController,
                      label: "سعر الشفت",
                      icon: Icons.monetization_on_outlined,
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val!.isEmpty ? "الرجاء إدخال سعر الشفت" : null,
                    ),
                    const Gap(16),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        buildTextField(
          controller: controller.salaryController,
          label: "درجة الوظيفية",
          icon: Icons.monetization_on_outlined,
          keyboardType: TextInputType.number,
          validator: (value) => value!.isEmpty ? "الرجاء إدخال الراتب" : null,
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: buildTextField(
                controller: controller.experienceController,
                label: "بدل الخبرة",
                icon: Icons.work_outline,
                keyboardType: TextInputType.number,
                validator: (val) => null,
              ),
            ),
            const Gap(10),
            Expanded(
              child: buildTextField(
                controller: controller.otherSalaryController,
                label: "أخرى",
                icon: Icons.add_circle_outline,
                keyboardType: TextInputType.number,
                validator: (val) => null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
