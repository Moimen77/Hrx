import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

// ignore: must_be_immutable
class Textfieldapp extends StatelessWidget {
  Textfieldapp({
    super.key,
    required this.controller,
    required this.hint,
    required this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
  });
  final TextEditingController controller;
  final String hint;
  final Widget suffixIcon;
  bool obscureText = false;

  Widget? prefixIcon;
  void Function(String)? onChanged;
  void Function()? onTap;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.right,
      readOnly: onTap != null ? true : false,
      obscureText: obscureText,
      style: cairoStyle(
        fontSize: 12.spAdaptive(context),
        fontcolor: Colors.black87,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: cairoStyle(
          fontSize: 12.spAdaptive(context),
          fontcolor: Colors.grey.shade600,
        ),

        labelStyle: cairoStyle(
          fontSize: 12.spAdaptive(context),
          fontcolor: Colors.grey.shade600,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      onTap: onTap,
      onChanged: onChanged,
      cursorHeight: 20,
      controller: controller,
    );
  }
}
