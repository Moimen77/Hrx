double latePenaltyToHours(String? type) {
  const double dayHours = 182 / 26;

  switch (type) {
    case 'quarter':
      return dayHours * 0.25;
    case 'half_day':
      return dayHours * 0.5;
    case 'full_day':
      return dayHours;
    default:
      return 0;
  }
}
