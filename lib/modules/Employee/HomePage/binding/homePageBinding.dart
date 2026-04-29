import 'package:get/get.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/HomePage/repo/HomePageRepo.dart';
import 'package:hrx/modules/Employee/HomePage/services/HomePageServices.dart';

class Homepagebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomepageServices());
    Get.lazyPut(() => Homepagerepo(Get.find()));
    Get.lazyPut(() => Homepagecontroller(Get.find()));
  }
}
