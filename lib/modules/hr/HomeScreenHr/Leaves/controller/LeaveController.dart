import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:hrx/modules/hr/HomePageHr/controller/HomeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/repo/LeaveRepostory.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/ButtonAddOrRejected.dart';

enum EnFromOrTo { to, from }

class LeaveController extends GetxController with NetworkAwareMixin {
  final LeaveRepository repo;

  LeaveController({required this.repo});

  RxList<LeaveModel> leaves = <LeaveModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool noMoreData = false.obs;
  var haserror = false.obs;

  late ActivityService activityService;

  ScrollController scrollController = ScrollController();
  int page = 0;
  final int pageLimit = 6;

  final RxInt currentUpdateLoadingLeaveID = 0.obs;

  RxBool isloadedApproved = false.obs;
  RxBool isloadedrejected = false.obs;
  String? selected_penalty;

  Rx<DateTime> DateFrom = DateTime.now()
      .subtract(const Duration(days: 335))
      .obs;
  Rx<DateTime> DateTo = DateTime.now().add(const Duration(days: 30)).obs;

  RxString searchQuery = "".obs;
  RxString statusFilter = "الكل".obs;
  List<String> statusList = ['الكل', 'مقبولة', 'مرفوضة', 'معلقة'];

  @override
  void onInit() {
    super.onInit();
    activityService = Get.find<ActivityService>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        loadMoreLeaves();
      }
    });

    fetchLeaves();
  }

  void changeSearch(String value) {
    searchQuery.value = value;
    fetchLeaves();
  }

  void changeStatusFilter(String status) {
    statusFilter.value = status;
    fetchLeaves();
  }

  Future<void> pickDate(BuildContext context, EnFromOrTo fromOrTo) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2080),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff197fe6),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (fromOrTo == EnFromOrTo.from) {
        DateFrom.value = picked;
      } else {
        DateTo.value = picked;
      }

      fetchLeaves();
    }
  }

  Future<void> fetchLeaves() async {
    isLoading.value = true;
    page = 0;
    noMoreData.value = false;
    haserror.value = false;

    try {
      final data = await repo.getLeaves(
        search: searchQuery.value,
        statusFilter: statusFilter.value,
        fromDate: DateFrom.value,
        toDate: DateTo.value,
        offset: page * pageLimit,
        limit: pageLimit,
      );

      leaves.value = data;
      if (data.length < pageLimit) {
        noMoreData.value = true;
      }
    } catch (e) {
      leaves.clear();
      haserror.value = true;
      noMoreData.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreLeaves() async {
    if (isLoadingMore.value || noMoreData.value) return;

    isLoadingMore.value = true;
    page++;

    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        noMoreData.value = true;
        return;
      }
      final data = await repo.getLeaves(
        search: searchQuery.value,
        statusFilter: statusFilter.value,
        fromDate: DateFrom.value,
        toDate: DateTo.value,
        offset: page * pageLimit,
        limit: pageLimit,
      );

      if (data.isEmpty) {
        noMoreData.value = true;
      } else {
        leaves.addAll(data);
      }
    } catch (e) {
      noMoreData.value = true;
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> addLeave(Map<String, dynamic> data) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      await repo.addLeave(data);
      fetchLeaves();
    } catch (e) {
      showErrorDialog(Get.context!, 'حدث خطأ أثناء إضافة الأجازة');
    }
  }

  Future<void> updateLeaveStatus(
    LeaveModel leave,
    BuildContext context,
    EnAcOrRej action,
  ) async {
    if (action == EnAcOrRej.reject) {
      _showRejectionPenaltyDialog(leave, context);
    } else {
      await _performUpdate(leave, context, null, action);
    }
  }

  void _showRejectionPenaltyDialog(LeaveModel leave, BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: EdgeInsets.all(width * 0.06),
          constraints: BoxConstraints(maxHeight: height * 0.65),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// أيقونة تحذير
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: width * 0.08,
                ),
              ),

              SizedBox(height: height * 0.02),

              /// العنوان
              Text(
                "رفض الأجازة",
                style: cairoStyle(
                  fontSize: width * 0.05,
                  fontweight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                "اختر عدد الأيام التي سيتم خصمها",
                textAlign: TextAlign.center,
                style: cairoStyle(
                  fontSize: width * 0.038,
                  fontcolor: Colors.grey[600],
                ),
              ),
              SizedBox(height: height * 0.025),

              /// خيارات الخصم
              Expanded(
                child: ListView(
                  children: [
                    _buildPenaltyOptionCard(leave, "خصم يوم واحد", "1"),
                    _buildPenaltyOptionCard(leave, "خصم يومين", "2"),
                    _buildPenaltyOptionCard(leave, "خصم ثلاثة أيام", "3"),
                    _buildPenaltyOptionCard(leave, "خصم أربعة أيام", "4"),
                  ],
                ),
              ),

              SizedBox(height: height * 0.015),

              /// زر إلغاء
              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    "إلغاء",
                    style: cairoStyle(
                      fontSize: width * 0.04,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPenaltyOptionCard(
    LeaveModel leave,
    String text,
    String? penaltyValue,
  ) {
    final width = Get.width;
    final height = Get.height;

    return GestureDetector(
      onTap: () {
        Get.back();
        selected_penalty = text;
        _performUpdate(leave, Get.context!, penaltyValue, EnAcOrRej.reject);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.015),
        padding: EdgeInsets.symmetric(
          vertical: height * 0.018,
          horizontal: width * 0.04,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: cairoStyle(
                fontSize: width * 0.04,
                fontweight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: width * 0.04,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performUpdate(
    LeaveModel leave,
    BuildContext context,
    String? hrDecision,
    EnAcOrRej action,
  ) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      final employeeName = leave.employeeName; // لو موجود عندك

      currentUpdateLoadingLeaveID.value = leave.id!;
      if (action == EnAcOrRej.reject) {
        isloadedrejected.value = true;
        leave.status = 'مرفوضة';
      } else {
        isloadedApproved.value = true;
        leave.status = 'مقبولة';
      }

      await repo.updateLeaveStatus(leave.id!, leave.status, hrDecision);

      final fcm = FCMService();

      if (leave.status == 'مرفوضة') {
        AppSnack.success("تم التحديث", ' تم رفض الأجازة بنجاح ');
        await fcm.sendNotification(
          title: 'رد الأجازة',
          body:
              'ال HR رفض الأجازة المطلوبة \n في حالة الغياب $selected_penalty',
          topic: leave.employeeId.toString(),
        );
        await activityService.log(
          type: ActivityType.rejectLeave,
          employeeId: leave.employeeId.toString(),
          metadata: {
            "employee_name": employeeName,
            "penalty": selected_penalty,
          },
        );
      } else {
        AppSnack.success("تم التحديث", 'تم قبول الأجازة بنجاح');
        await repo.deduct_leave_days(leave.toJson());
        await fcm.sendNotification(
          title: 'رد الأجازة',
          body: 'ال HR وافق علي الأجازة المطلوبة',
          topic: leave.employeeId.toString(),
        );
        await activityService.log(
          type: ActivityType.approveLeave,
          employeeId: leave.employeeId.toString(),
          metadata: {"employee_name": employeeName},
        );
      }
      await Get.find<HomeController>().fetchHomeData();
      await fetchLeaves();
    } catch (e) {
      showErrorDialog(context, 'حدث خطأ أثناء تحديث حالة الأجازة: $e');
    } finally {
      currentUpdateLoadingLeaveID.value = 0;
      isloadedApproved.value = false;
      isloadedrejected.value = false;
    }
  }
}
