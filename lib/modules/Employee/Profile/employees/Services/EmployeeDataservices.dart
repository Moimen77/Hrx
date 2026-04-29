// ignore_for_file: non_constant_identifier_names

import 'package:supabase_flutter/supabase_flutter.dart';

class Hrdataservices {
  final client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> GetprofileData() async {
    String user_id = client.auth.currentUser!.id;
    print(user_id);
    final res = await client.from('Hrs').select().eq('user_id', user_id);
    return res;
  }
}
