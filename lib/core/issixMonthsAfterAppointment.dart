bool issixMonthsAfterAppointment(DateTime appointmentDate) {
  final sixMonthsAfterAppointment = DateTime(
    appointmentDate.year,
    appointmentDate.month + 6,
    appointmentDate.day,
  );
  final bool isEligibleForAnnualLeave = DateTime.now().isAfter(
    sixMonthsAfterAppointment,
  );
  return isEligibleForAnnualLeave;
}
