// f:\Flutter\hrx\lib\modules\HomeScreen\Home\controller\HomeController.dart

import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/HomePageModel.dart';
import 'package:hrx/modules/hr/HomePageHr/repo/HomePageRepo.dart';

class HomeController extends GetxController {
  final HomeRepository repo;

  HomeController({required this.repo});

  RxBool isLoading = false.obs;
  var hasError = false.obs;
  Rx<HomeStatisticsModel?> statistics = Rx<HomeStatisticsModel?>(null);
  final networkController = Get.find<NetworkController>();
  late Myservices myservices;
  String username = 'Hr Manager';

  // للحصول على التاريخ الحالي بالصيغة العربية
  String get currentDate => TimeHelper.formatDateToArabic(DateTime.now());

  @override
  void onInit() {
    super.onInit();
    myservices = Get.find<Myservices>();
    username = myservices.sharedPref.getString('Username') ?? 'Hr Manager';
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final data = await repo.getHomeStatistics();
      var RecentActivities = await repo.getRecentActivities();
      data.recentActivities = RecentActivities;
      statistics.value = data;
    } catch (e) {
      hasError.value = true;
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء تحميل البيانات');
    } finally {
      isLoading.value = false;
    }
  }
}
