import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
      margin: EdgeInsets.symmetric(
        vertical: 8.spAdaptive(context),
        horizontal: 4.spAdaptive(context),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.spAdaptive(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12.spAdaptive(context),
              runSpacing: 8.spAdaptive(context),
              children: [
                Text(
                  'طلب سلفة #${advance.id}',
                  style: cairoStyle(
                    fontweight: FontWeight.bold,
                    fontSize: 16.spAdaptive(context),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.spAdaptive(context),
                    vertical: 4.spAdaptive(context),
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(advance.status ?? ''),
                    borderRadius: BorderRadius.circular(20.spAdaptive(context)),
                  ),
                  child: Text(
                    advance.status ?? 'غير محدد',
                    style: cairoStyle(
                      fontcolor: Colors.white,
                      fontSize: 12.spAdaptive(context),
                    ),
                  ),
                ),
              ],
            ),
            Gap(10.spAdaptive(context)),
            const Divider(),
            Gap(10.spAdaptive(context)),
            _buildInfoRow(
              context: context,
              icon: Icons.monetization_on_outlined,
              label: 'المبلغ المطلوب: ',
              value:
                  '${advance.requestedAmount?.toStringAsFixed(2) ?? '0.00'} ج.م',
            ),
            Gap(8.spAdaptive(context)),
            _buildInfoRow(
              context: context,
              icon: Icons.calendar_today_outlined,
              label: 'تاريخ الطلب: ',
              value: _formatDate(advance.requestDate.toString()),
            ),
            if (advance.approvedAmount != null) ...[
              Gap(8.spAdaptive(context)),
              _buildInfoRow(
                context: context,
                icon: Icons.account_balance_wallet_outlined,
                label: 'المبلغ الموافق عليه: ',
                value: '${advance.approvedAmount!.toStringAsFixed(2)} ج.م',
              ),
            ],
            if (advance.note != null && advance.note!.trim().isNotEmpty) ...[
              Gap(8.spAdaptive(context)),
              _buildInfoRow(
                context: context,
                icon: Icons.notes_outlined,
                label: 'ملاحظات: ',
                value: advance.note!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blueGrey, size: 20.spAdaptive(context)),
        Gap(8.spAdaptive(context)),
        Expanded(
          child: Wrap(
            runSpacing: 4.spAdaptive(context),
            children: [
              Text(
                label,
                style: cairoStyle(
                  fontcolor: Colors.grey.shade700,
                  fontSize: 14.spAdaptive(context),
                ),
              ),
              Text(
                value,
                style: cairoStyle(
                  fontweight: FontWeight.bold,
                  fontSize: 14.spAdaptive(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
