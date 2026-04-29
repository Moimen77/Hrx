import 'package:supabase_flutter/supabase_flutter.dart';

class hrHomeServices {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>> getDashboardStats() async {
    final response = await _client.rpc('get_hr_dashboard_stats');
    return response.first;
  }

  Future<List<Map<String, dynamic>>> getRecentActivities() async {
    final response = await _client
        .from('activity_logs')
        .select()
        .order('created_at', ascending: false);
    print('res $response');
    return response;
  }
}
