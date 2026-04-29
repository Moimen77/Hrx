import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            return const Center(child: Text('لم يتم العثور على بيانات الموظف'));
          }

          final employee = controller.employee.value!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
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
                            radius: 50,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: employee.imageUrl != null
                                ? NetworkImage(employee.imageUrl!)
                                : null,
                            child: employee.imageUrl == null
                                ? const Icon(Icons.person, size: 40)
                                : null,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.pickAndUploadImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xff197FE6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        employee.name ?? '',
                        style: cairoStyle(
                          fontSize: 20,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        employee.departmentName ?? '',
                        style: cairoStyle(fontcolor: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                /// Settings
                _SettingsCard(
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: controller.notificationsEnabled.value,
                        onChanged: controller.toggleNotifications,
                        title: Text(
                          'الإشعارات',
                          style: cairoStyle(
                            fontSize: 16,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'تفعيل / تعطيل الإشعارات',
                          style: cairoStyle(fontSize: 12),
                        ),
                        secondary: _iconBox(Icons.notifications),
                      ),
                      const Divider(),
                      ListTile(
                        leading: _iconBox(Icons.support_agent),
                        title: Text(
                          'الدعم والموارد البشرية',
                          style: cairoStyle(
                            fontSize: 16,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'تواصل عبر واتساب',
                          style: cairoStyle(fontSize: 12),
                        ),
                        onTap: controller.openWhatsApp,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                /// Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      confirmLogout(controller.logout);
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      'تسجيل الخروج',
                      style: cairoStyle(
                        fontSize: 16,
                        fontcolor: Colors.white,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        }),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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

Widget _iconBox(IconData icon) {
  return CircleAvatar(
    backgroundColor: const Color(0xffE8F1FD),
    child: Icon(icon, color: const Color(0xff197FE6)),
  );
}
