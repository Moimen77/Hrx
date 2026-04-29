import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class NoPermissionWidget extends StatelessWidget {
  const NoPermissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80.spAdaptive(context),
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد أذونات مسجلة',
            style: cairoStyle(
              fontSize: 16.spAdaptive(context),
              fontcolor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
