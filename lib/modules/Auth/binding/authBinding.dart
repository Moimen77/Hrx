import 'package:get/get.dart';
import 'package:hrx/modules/Auth/Controllers/auth_controller.dart';
import 'package:hrx/modules/Auth/reposity/auth_repository.dart';
import 'package:hrx/modules/Auth/services/supabase_Auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupabaseAuthService());
    Get.lazyPut(() => AuthRepository(Get.find()));
    Get.lazyPut(() => AuthController(Get.find()));
  }
}
