import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/HrInfoHeader.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/LogOutButton.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/MangementsCards.dart';

class ProfileScreenForm extends StatelessWidget {
  const ProfileScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HrInfoHeader(width: width),
              const Gap(8),
              MangementsCards(),
              const Gap(10),
              LogoutButton(width: width),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
