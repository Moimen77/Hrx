// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hrx/core/services/activityServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservices extends GetxService {
  late SharedPreferences sharedPref;

  Future<Myservices> init() async {
    sharedPref = await SharedPreferences.getInstance();
    return this;
  }
}

Future initializeservices() async {
  await Get.putAsync(() => Myservices().init());
  await Get.putAsync<ActivityService>(() async {
    return ActivityService();
  });
}
