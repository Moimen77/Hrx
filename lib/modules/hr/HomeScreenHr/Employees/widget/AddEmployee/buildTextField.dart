// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

// ignore: camel_case_types
class buildTextField extends StatelessWidget {
  buildTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.readOnly,
    this.onChanged,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  void Function()? onTap;
  bool? readOnly;
  TextInputType? keyboardType;
  final String? Function(String?)? validator;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: cairoStyle(fontcolor: Appcolors.primarycolor, fontSize: 14),
        prefixIcon: Icon(icon, color: Appcolors.primarycolor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Appcolors.primarycolor, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
    );
  }
}
