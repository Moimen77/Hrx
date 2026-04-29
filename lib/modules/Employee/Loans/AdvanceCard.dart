import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/LoanModel.dart';

import 'package:intl/intl.dart';

class AdvanceCard extends StatelessWidget {
  final AdvanceModel advance;

  const AdvanceCard({super.key, required this.advance});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'مقبولة':
        return Colors.green;
      case 'مرفوضة':
        return Colors.red;
      case 'معلقة':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب سلفة #${advance.id}',
                  style: cairoStyle(fontweight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(advance.status ?? ''),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    advance.status ?? 'غير محدد',
                    style: cairoStyle(fontcolor: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Divider(),
            const Gap(10),
            _buildInfoRow(
              icon: Icons.monetization_on_outlined,
              label: 'المبلغ المطلوب: ',
              value:
                  '${advance.requestedAmount?.toStringAsFixed(2) ?? '0.00'} ج.م',
            ),
            const Gap(8),
            _buildInfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'تاريخ الطلب: ',
              value: _formatDate(advance.requestDate.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey, size: 20),
        const Gap(8),
        Text(label, style: cairoStyle(fontcolor: Colors.grey.shade700)),
        Text(value, style: cairoStyle(fontweight: FontWeight.bold)),
      ],
    );
  }
}
