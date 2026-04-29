import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';

class Employeetextsearch extends GetView<EmployeesController> {
  const Employeetextsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: controller.updateSearchQuery,
        decoration: InputDecoration(
          hintText: "ابحث بالاسم...",
          hintStyle: cairoStyle(),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
