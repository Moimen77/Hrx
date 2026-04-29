import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileController.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileRepo.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileService.dart';

class Profilebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(ProfileRepository(ProfileService())));
  }
}
