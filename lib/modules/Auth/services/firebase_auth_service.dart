import 'package:firebase_auth/firebase_auth.dart';
import 'package:hrx/data/models/userModel.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel?> login(String email, String password) async {
    final userCred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCred.user != null) {
      return UserModel(id: userCred.user!.uid, email: userCred.user!.email!);
    }

    return null;
  }

  Future<void> Forgetpassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("تم إرسال البريد بنجاح");
    } catch (e) {
      print("خطأ في إرسال البريد: $e");
      rethrow; // لتستمر الأخطاء لتظهر في resetPassword
    }
  }
}
