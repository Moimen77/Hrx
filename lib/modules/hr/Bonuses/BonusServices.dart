import 'package:hrx/data/models/BonusModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BonusService {
  final supabase = Supabase.instance.client;

  Future<List<BonusModel>> getBonuses() async {
    final response = await supabase
        .from('bonuses')
        .select('''
          *,
          employee:Employees(
           *
          )
        ''')
        .order('bonus_date', ascending: false);

    return (response as List).map((e) => BonusModel.fromJson(e)).toList();
  }

  Future<void> updateBonus(int id, Map<String, dynamic> data) async {
    await supabase.from('bonuses').update(data).eq('id', id);
  }
}
