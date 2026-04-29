import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityService extends GetxService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> log({
    required String type,
    String? employeeId,
    Map<String, dynamic>? metadata,
  }) async {
    await supabase.from('activity_logs').insert({
      'type': type,
      'employee_id': employeeId,
      'metadata': metadata ?? {},
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
