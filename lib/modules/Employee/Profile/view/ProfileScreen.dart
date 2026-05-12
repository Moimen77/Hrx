import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/AlertLogOut.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileController.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'الملف الشخصي'),
        backgroundColor: const Color(0xffF5F7FA),
        body: Obx(() {
          if (!controller.networkController.isConnected.value) {
            return NoInternetWidget(
              onPressed: () async {
                await controller.fetchEmployeeProfile();
                await Get.find<Homepagecontroller>().loadall();
              },
            );
          }
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.employee.value == null) {
            return Center(
              child: Text(
                'لم يتم العثور على بيانات الموظف',
                style: cairoStyle(fontSize: 15.spAdaptive(context)),
              ),
            );
          }

          final employee = controller.employee.value!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 24 : 16),
            child: Column(
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop
                          ? 1180
                          : isTablet
                          ? 860
                          : double.infinity,
                    ),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: _ProfileCard(
                                  employee: employee,
                                  onEditImage: controller.pickAndUploadImage,
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    _SettingsSection(controller: controller),
                                    SizedBox(height: 30),
                                    _LogoutButton(onPressed: controller.logout),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _ProfileCard(
                                employee: employee,
                                onEditImage: controller.pickAndUploadImage,
                              ),
                              SizedBox(height: 24.spAdaptive(context)),
                              _SettingsSection(controller: controller),
                              SizedBox(height: 30.spAdaptive(context)),
                              _LogoutButton(onPressed: controller.logout),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 20.spAdaptive(context)),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.employee, required this.onEditImage});

  final dynamic employee;
  final Future<void> Function() onEditImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.spAdaptive(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.spAdaptive(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50.spAdaptive(context),
                backgroundColor: Colors.grey.shade200,
                backgroundImage: employee.imageUrl != null
                    ? NetworkImage(employee.imageUrl!)
                    : null,
                child: employee.imageUrl == null
                    ? Icon(Icons.person, size: 40.spAdaptive(context))
                    : null,
              ),
              GestureDetector(
                onTap: onEditImage,
                child: Container(
                  padding: EdgeInsets.all(6.spAdaptive(context)),
                  decoration: const BoxDecoration(
                    color: Color(0xff197FE6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 16.spAdaptive(context),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.spAdaptive(context)),
          Text(
            employee.name ?? '',
            textAlign: TextAlign.center,
            style: cairoStyle(
              fontSize: 20.spAdaptive(context),
              fontweight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.spAdaptive(context)),
          Text(
            employee.departmentName ?? '',
            textAlign: TextAlign.center,
            style: cairoStyle(
              fontcolor: Colors.grey,
              fontSize: 13.spAdaptive(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      child: Column(
        children: [
          SwitchListTile(
            value: controller.notificationsEnabled.value,
            onChanged: controller.toggleNotifications,
            title: Text(
              'الإشعارات',
              style: cairoStyle(
                fontSize: 16.spAdaptive(context),
                fontweight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'تفعيل / تعطيل الإشعارات',
              style: cairoStyle(fontSize: 12.spAdaptive(context)),
            ),
            secondary: _iconBox(context, Icons.notifications),
          ),
          Divider(height: 1.spAdaptive(context)),
          ListTile(
            leading: _iconBox(context, Icons.support_agent),
            title: Text(
              'الدعم والموارد البشرية',
              style: cairoStyle(
                fontSize: 16.spAdaptive(context),
                fontweight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'تواصل عبر واتساب',
              style: cairoStyle(fontSize: 12.spAdaptive(context)),
            ),
            onTap: controller.openWhatsApp,
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          confirmLogout(onPressed);
        },
        icon: Icon(
          Icons.logout,
          color: Colors.white,
          size: 20.spAdaptive(context),
        ),
        label: Text(
          'تسجيل الخروج',
          style: cairoStyle(
            fontSize: 16.spAdaptive(context),
            fontcolor: Colors.white,
            fontweight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          padding: EdgeInsets.symmetric(vertical: 14.spAdaptive(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.spAdaptive(context)),
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.spAdaptive(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.spAdaptive(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

Widget _iconBox(BuildContext context, IconData icon) {
  return CircleAvatar(
    radius: 25.spAdaptive(context),
    backgroundColor: const Color(0xffE8F1FD),
    child: Icon(
      icon,
      color: const Color(0xff197FE6),
      size: 20.spAdaptive(context),
    ),
  );
}
