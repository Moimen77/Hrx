import 'package:hrx/data/models/offical_holiday.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OfficialHolidaysRepo {
  final supabase = Supabase.instance.client;

  // جلب كل العطلات
  Future<List<HolidayModel>> getHolidays() async {
    final response = await supabase
        .from('official_holidays')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((e) => HolidayModel.fromJson(e)).toList();
  }

  // إضافة عطلة جديدة
  Future<void> addHoliday(HolidayModel holiday) async {
    await supabase.from('official_holidays').insert(holiday.toJson());
  }

  // حذف عطلة
  Future<void> deleteHoliday(int id) async {
    await supabase.from('official_holidays').delete().eq('id', id);
  }
}
