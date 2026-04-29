import 'package:hrx/data/models/ShiftsModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShiftService {
  final supabase = Supabase.instance.client;

  Future<List<ShiftModel>> getShifts() async {
    final res = await supabase.from('shiftview').select();
    return (res as List).map((e) => ShiftModel.fromJson(e)).toList();
  }

  Future<void> activateSeason(String seasonName) async {
    await supabase.from('seasons').update({"is_active": false}).neq('id', 0);

    await supabase
        .from('seasons')
        .update({"is_active": true})
        .eq('name', seasonName);
  }

  Future<String?> getActiveSeason() async {
    final res = await supabase
        .from('seasons')
        .select()
        .eq("is_active", true)
        .maybeSingle();

    return res?['name'];
  }
}
