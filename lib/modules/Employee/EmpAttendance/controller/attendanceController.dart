import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/staticNumbers.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/data/models/ShiftsModel.dart';
import 'package:hrx/modules/Employee/EmpAttendance/repo/AttendanceRepo.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';

class Attendancecontroller extends GetxController with NetworkAwareMixin {
  final Attendancerepo repo;
  Attendancecontroller({required this.repo});
  late Homepagecontroller homepagecontroller;
  RxBool isloading = false.obs;
  RxBool isCheckinloading = false.obs;

  RxList<BranchModel> branches = <BranchModel>[].obs;
  RxList<ShiftModel> shifts = <ShiftModel>[].obs;

  RxString statusMessage = "".obs;

  Rx<BranchModel?> selectedBranch = Rx<BranchModel?>(null);
  Rx<ShiftModel?> selectedShift = Rx<ShiftModel?>(null);

  Rx<Position?> currentPosition = (null as Position?).obs;

  changeBranch(String v) {
    selectedBranch.value = branches.firstWhere((element) => element.name == v);
  }

  changeShift(String v) {
    selectedShift.value = shifts.firstWhere((element) => element.name == v);
  }

  @override
  void onInit() {
    homepagecontroller = Get.find<Homepagecontroller>();
    loadData();
    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      statusMessage.value = "يرجى تمكين الموقع على الجهاز.";
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        statusMessage.value = "تم رفض صلاحية الموقع.";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      statusMessage.value = "تم رفض صلاحية الموقع نهائيًا.";
      return;
    }

    // 3️⃣ الحصول على الموقع
    currentPosition.value = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // تسجيل الحضور
  Future<void> checkIn(BuildContext context) async {
    if (selectedBranch.value == null || selectedShift.value == null) {
      showErrorDialog(context, "اختر الفرع والشيفت أولاً.");
      return;
    }

    try {
      isCheckinloading.value = true;
      if (!await ensureInternetConnection()) {
        return;
      }

      if (currentPosition.value == null) {
        await getCurrentLocation();
        if (currentPosition.value == null) {
          showErrorDialog(context, statusMessage.value);
          isCheckinloading.value = false;
          return;
        }
      }

      // التحقق إذا الموظف داخل حدود الفرع
      double distance = Geolocator.distanceBetween(
        selectedBranch.value!.lat,
        selectedBranch.value!.lng,
        currentPosition.value!.latitude,
        currentPosition.value!.longitude,
      );
      print(distance);

      if (distance > avilableDistance) {
        showErrorDialog(context, "أنت خارج حدود الفرع، لا يمكن تسجيل الحضور.");
        isCheckinloading.value = false;
        return;
      }
      await repo.checkIn(
        homepagecontroller.Employee!.id!,
        selectedBranch.value!.id!,
        selectedShift.value!.id,
      );

      AppSnack.success('تم', "تم تسجيل الحضور بنجاح.");
      FCMService fcm = FCMService();
      await fcm.sendNotification(
        body: 'الموظف ${homepagecontroller.Employee!.name} سجل الحضور',
        title: 'تسجيل حضور',
        topic: 'hr',
      );
      print('notification Done');
      print(homepagecontroller.isCheckedIn);
      await homepagecontroller.loadall();
      print(homepagecontroller.isCheckedIn);
      Navigator.of(context).pop();
    } catch (e) {
      showErrorDialog(context, "حدث خطأ: ${e.toString()}");
    } finally {
      isCheckinloading.value = false;
    }
  }

  loadData() async {
    try {
      isloading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final fetchedBranches = await repo.getBranches();
      branches.value = fetchedBranches;
      final fetchedShifts = await repo.getShifts(
        homepagecontroller.Employee!.employeeType ?? 'full_time',
      );
      shifts.value = fetchedShifts;
      if (branches.isNotEmpty) {
        selectedBranch.value = branches.first;
      }
      if (shifts.isNotEmpty) {
        selectedShift.value = shifts.first;
      }
      isloading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }
}
