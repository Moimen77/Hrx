import 'package:hrx/data/models/PenalitesModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PenaltyService {
  final supabase = Supabase.instance.client;

  Future<List<PenaltyModel>> getPenalties() async {
    final response = await supabase
        .from('penalties')
        .select('''
          *,
          employee:Employees(
           *
          )
        ''')
        .order('penalty_date', ascending: false);

    return (response as List).map((e) => PenaltyModel.fromJson(e)).toList();
  }

  Future<void> addPenalty(Map<String, dynamic> data) async {
    await supabase.from('penalties').insert(data);
  }

  Future<void> updatePenalty(int id, Map<String, dynamic> data) async {
    await supabase.from('penalties').update(data).eq('id', id);
  }

  Future<void> deletePenalty(int id) async {
    await supabase.from('penalties').delete().eq('id', id);
  }
}
