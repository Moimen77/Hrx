import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10.spAdaptive(context)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.spAdaptive(context),
              child: Icon(
                icon,
                color: const Color(0xff1e293b),
                size: 20.spAdaptive(context),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: cairoStyle(fontSize: 13.spAdaptive(context)),
                  ),
                  const Gap(3),
                  Text(
                    subtitle,
                    style: cairoStyle(
                      fontcolor: const Color(0xff939eae),
                      fontSize: 13.spAdaptive(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
