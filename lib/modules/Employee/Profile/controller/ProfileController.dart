import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileRepo.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController with NetworkAwareMixin {
  final ProfileRepository profileRepository;
  final Myservices myservices = Get.find();

  ProfileController(this.profileRepository);

  var employee = Rxn<EmployeeModel>();
  var isLoading = true.obs;
  RxString avatarUrl = ''.obs;

  // الإشعارات
  RxBool notificationsEnabled = true.obs;

  // رقم HR
  final String hrWhatsAppNumber = "201554604220";
  void toggleNotifications(bool value) {
    if (!value) {
      FirebaseMessaging.instance.unsubscribeFromTopic(
        employee.value!.id.toString(),
      );
    } else {
      FirebaseMessaging.instance.subscribeToTopic(
        employee.value!.id.toString(),
      );
    }
    notificationsEnabled.value = value;
  }

  Future<void> pickAndUploadImage() async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        final file = File(image.path);
        final fileName =
            'emp_${employee.value!.id}_${DateTime.now().millisecondsSinceEpoch}.${image.path.split('.').last}';
        await profileRepository.updateProfileImage(
          fileName,
          file,
          employee.value!.id!,
        );
        await fetchEmployeeProfile();
        await Get.find<Homepagecontroller>().loadall();
        AppSnack.success('تم التحميل بنجاح', 'تم تحديث الصورة بنجاح');
      }
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء تحميل الصورة');
    }
  }

  Future<void> openWhatsApp() async {
    final appUrl = Uri.parse("whatsapp://send?phone=$hrWhatsAppNumber");
    final webUrl = Uri.parse("https://wa.me/$hrWhatsAppNumber");

    if (await canLaunchUrl(appUrl)) {
      await launchUrl(appUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    }
  }

  
  void logout() async {
    await myservices.sharedPref.clear();
    await myservices.sharedPref.setBool('IsLogin', false);
    await myservices.sharedPref.setBool('onBoardingSeen', true);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeProfile();
  }

  Future<void> fetchEmployeeProfile() async {
    try {
      isLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final employees = await profileRepository.getEmployeeProfileData();
      if (employees.isNotEmpty) {
        employee.value = employees.first;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
