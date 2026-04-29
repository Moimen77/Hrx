import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Icon(icon, color: Color(0xff1e293b)),
            ),
            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: cairoStyle(fontSize: 13)),
                  const Gap(3),
                  Text(
                    subtitle,
                    style: cairoStyle(
                      fontcolor: const Color(0xff939eae),
                      fontSize: 13,
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
