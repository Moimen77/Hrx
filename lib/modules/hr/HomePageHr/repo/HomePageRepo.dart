// f:\Flutter\hrx\lib\modules\HomeScreen\Home\repo\HomeRepository.dart

import 'package:hrx/data/models/HomePageModel.dart';
import 'package:hrx/data/models/activityModel.dart';
import 'package:hrx/modules/hr/HomePageHr/services/HrServices.dart';

class HomeRepository {
  hrHomeServices services = hrHomeServices();
  HomeRepository(this.services);

  Future<HomeStatisticsModel> getHomeStatistics() async {
    final dashboardStats = await services.getDashboardStats();

    return HomeStatisticsModel.fromJson(dashboardStats);
  }

  Future<List<ActivityLogModel>> getRecentActivities() async {
    final activities = await services.getRecentActivities();

    return activities
        .map((activity) => ActivityLogModel.fromJson(activity))
        .toList();
  }
}
