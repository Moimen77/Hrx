String translateBasicSalaryKey(String key) {
  const map = {
    'salary': 'مربوط الدرجة الوظيفية',
    'job_grade': 'اقدمية/خبرة',
    'experience_salary': 'بدل خبرة',
    'other_salary': 'بدلات أخرى',
    'raises': 'زيادات سنوية',
  };
  return map[key] ?? key;
}

String translateHoursKey(String key) {
  final map = {
    'total': 'إجمالي الساعات',
    'net': 'الصافي',
    'real': 'ساعات فعلية',
    'leave': 'إجازات',
    'overtime': 'إضافي',
    'absent': 'غياب (ساعات)',
    'deducted': 'مخصوم (تأخير)',
    'friday2': 'جمعة (حضور)',
    'permission': 'أذونات',
    'fridayAndHoliday': 'عطلات رسمية',
  };
  return map[key] ?? key;
}
