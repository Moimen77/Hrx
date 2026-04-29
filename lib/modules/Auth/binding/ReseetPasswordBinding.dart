import 'package:get/get.dart';
import 'package:hrx/modules/Auth/Controllers/ReseetPassController.dart';
import 'package:hrx/modules/Auth/reposity/auth_repository.dart';
import 'package:hrx/modules/Auth/services/supabase_Auth_service.dart';

class Reseetpasswordbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupabaseAuthService());
    Get.lazyPut(() => AuthRepository(Get.find()));
    Get.lazyPut(() => Reseetpasscontroller());
  }
}
