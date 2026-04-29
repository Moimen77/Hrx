import 'package:hrx/data/models/userModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>?> getCurrentHr() async {
    return await _client
        .from('Hrs')
        .select('name, is_active')
        .eq('user_id', _client.auth.currentUser!.id)
        .maybeSingle();
  }

  Future<UserModel?> login(String email, String password) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = res.user;
    if (user != null) {
      return UserModel(id: user.id, email: user.email ?? '');
    }
    return null;
  }

  Future<bool> isHr(String email) async {
    final user = await getCurrentHr();
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getEmployeeProfileData() async {
    String uid = _client.auth.currentUser!.id;
    final res = await _client
        .from('employees_view')
        .select()
        .eq('user_id', uid);

    return res;
  }

  Future<String> getHrUserName() async {
    final user = await getCurrentHr();
    if (user != null) {
      final name = user['name'];
      return name!;
    } else {
      return 'Hr Manager';
    }
  }

  Future<bool> isCurrentHrActive() async {
    final user = await getCurrentHr();
    return user?['is_active'] == true;
  }

  Future activatesession(String code) async {
    await _client.auth.exchangeCodeForSession(code);
  }

  Future updatePassword(String newPassword) async {
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'myapp://reset-password',
    );
  }

  Future<UserModel?> register(String email, String password) async {
    final res = await _client.auth.signUp(email: email, password: password);
    final user = res.user;
    if (user != null) {
      return UserModel(id: user.id, email: user.email ?? '');
    }
    return null;
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
