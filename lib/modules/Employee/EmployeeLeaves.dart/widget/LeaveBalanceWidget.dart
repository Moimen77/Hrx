import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/issixMonthsAfterAppointment.dart';
import 'package:hrx/data/models/LeaveBalanceModel.dart';

class LeaveBalanceCard extends StatelessWidget {
  final EmployeeLeaveBalance balance;
  final DateTime appointmentDate;

  const LeaveBalanceCard({
    super.key,
    required this.balance,
    required this.appointmentDate,
  });

  @override
  Widget build(BuildContext context) {
    final bool sixMonthsAfterAppointment = issixMonthsAfterAppointment(
      appointmentDate,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: sixMonthsAfterAppointment
          ? Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رصيد الأجازات',
                      style: cairoStyle(
                        fontSize: 18,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    const Gap(16),
                    _buildRow(
                      title: 'أجازة عارضة',
                      used: balance.casualUsed,
                      total: balance.casualTotal,
                      color: Colors.orange,
                    ),
                    const Gap(12),

                    _buildRow(
                      title: 'أجازة اعتيادي',
                      used: balance.annualUsed,
                      total: balance.annualTotal,
                      color: Colors.green,
                    ),
                    const Divider(height: 32, thickness: 0.5),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'الفترة: '
                        '${balance.periodStart.year}/${balance.periodStart.month.toString().padLeft(2, '0')} '
                        '→ '
                        '${balance.periodEnd.year}/${balance.periodEnd.month.toString().padLeft(2, '0')}',
                        style: cairoStyle(
                          fontcolor: Colors.grey.shade700,
                          fontSize: 12,
                          fontweight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'رصيد الأجازات غير متاح بعد',
                    style: cairoStyle(
                      fontSize: 16,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildRow({
    required String title,
    required int used,
    required int total,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: cairoStyle(fontweight: FontWeight.w600, fontSize: 15),
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : used / total,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(color),
                  minHeight: 8,
                ),
              ),
            ),
            const Gap(12),
            Text(
              '$used / $total',
              style: cairoStyle(fontweight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
