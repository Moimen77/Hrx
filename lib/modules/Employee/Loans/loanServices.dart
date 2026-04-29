import 'package:supabase_flutter/supabase_flutter.dart';

class AdvanceServices {
  // هنا يتم وضع كود الاتصال بالـ API (مثل Dio أو http أو Crud class الخاص بك)
  // هذا مثال توضيحي
  Future<dynamic> submitAdvanceRequest(Map<String, dynamic> data) async {
    final _client = Supabase.instance.client;
    // محاكاة استجابة ناجحة للتجربة
    await _client.from('employee_advances').insert(data);
    await Future.delayed(const Duration(seconds: 2));
    return {"status": "success", "message": "تم تقديم الطلب بنجاح"};
  }
}
