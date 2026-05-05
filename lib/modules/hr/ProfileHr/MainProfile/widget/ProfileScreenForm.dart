import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/HrInfoHeader.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/LogOutButton.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/MangementsCards.dart';

class ProfileScreenForm extends StatelessWidget {
  const ProfileScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 24 : 15,
            vertical: isDesktop ? 20 : 10,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop
                    ? 1200
                    : isTablet
                    ? 920
                    : double.infinity,
              ),
              child: isDesktop ? _desktopLayout() : _mobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobileLayout() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HrInfoHeader(),
        Gap(12),
        MangementsCards(),
        Gap(12),
        LogoutButton(),
        Gap(10),
      ],
    );
  }

  Widget _desktopLayout() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(children: [HrInfoHeader(), Gap(16), LogoutButton()]),
        ),
        Gap(24),
        Expanded(flex: 7, child: MangementsCards()),
      ],
    );
  }
}
