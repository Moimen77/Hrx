class translationFunctions {
  static Map<String, String> translationsShifts = {
    'full_time': 'شيفتات باقي الشركة',
    'shifts': ' شيفتات (الأشعة)',
    'marketing': 'التسويق شيفتات',
  };

  static String translationsShiftsTitle(String employeeType) {
    return translationsShifts[employeeType] ?? '';
  }
}
