import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Dropdownaddemployee<T> extends StatelessWidget {
  const Dropdownaddemployee({
    super.key,
    this.value,
    required this.onChanged,
    required this.items,
    required this.title,
    required this.icon,
  });

  final IconData icon;
  final String title;
  final T? value;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      items: items,
      itemHeight: 60.spAdaptive(context).clamp(48, 80),
      style: cairoStyle(fontSize: 14.spAdaptive(context)),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.spAdaptive(context),
          horizontal: 12.spAdaptive(context),
        ),

        labelText: title,
        labelStyle: cairoStyle(
          fontSize: 14.spAdaptive(context),
          fontweight: FontWeight.w600,
        ),

        prefixIcon: Icon(
          icon,
          color: Appcolors.primarycolor,
          size: 20.spAdaptive(context),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
