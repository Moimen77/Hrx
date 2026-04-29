import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/userModel.dart';
import 'package:hrx/modules/Auth/services/supabase_Auth_service.dart';

class AuthRepository {
  // final FirebaseAuthService firebaseService;
  final SupabaseAuthService supabaseService;

  AuthRepository(this.supabaseService);

  Future<UserModel?> login(String email, String password) async {
    return await supabaseService.login(email, password);
  }

  Future<bool> isHr(String email) async {
    return await supabaseService.isHr(email);
  }

  Future<List<EmployeeModel>> GetProfileData() async {
    final res = await supabaseService.getEmployeeProfileData();
    final List<EmployeeModel> Employees = res
        .map((e) => EmployeeModel.fromMap(e))
        .toList();

    return Employees;
  }

  Future<String> getHrUserName() async {
    return await supabaseService.getHrUserName();
  }

  Future<bool> isCurrentHrActive() async {
    return await supabaseService.isCurrentHrActive();
  }

  Future<void> activatesession(String code) async {
    return await supabaseService.activatesession(code);
  }

  Future<void> updatePassword(String newPassword) async {
    return await supabaseService.updatePassword(newPassword);
  }

  Future<void> Forgetpassword(String email) async {
    return await supabaseService.resetPassword(email);
  }
}
