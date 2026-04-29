import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/hr/Loans/controller/LoanController.dart';
import 'package:hrx/modules/hr/Loans/widget/StatusLoanBadge.dart';
import 'package:intl/intl.dart';

class AdvanceCard extends StatelessWidget {
  final AdvanceModel advance;

  const AdvanceCard({super.key, required this.advance});

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
    final controller = Get.find<AdvanceArchiveController>();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 420;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.spAdaptive(context),
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: advance.imgUrl != null
                          ? NetworkImage(advance.imgUrl!)
                          : null,
                      child: advance.imgUrl == null
                          ? Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 22.spAdaptive(context),
                            )
                          : null,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isCompact) ...[
                            Text(
                              'طلب سلفة #${advance.id}',
                              style: cairoStyle(
                                fontweight: FontWeight.bold,
                                fontSize: 15.spAdaptive(context),
                              ),
                            ),
                            const Gap(8),
                            StatusLoanBadge(context, status: advance.status),
                          ] else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'طلب سلفة #${advance.id}',
                                    style: cairoStyle(
                                      fontweight: FontWeight.bold,
                                      fontSize: 16.spAdaptive(context),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                StatusLoanBadge(
                                  context,
                                  status: advance.status,
                                ),
                              ],
                            ),
                          const Gap(10),
                          const Divider(),
                          const Gap(10),
                          _buildInfoRow(
                            context: context,
                            icon: Icons.person_outline_outlined,
                            label: ' اسم الموظف: ',
                            value: advance.employeeName ?? 'N/A',
                          ),
                          const Gap(10),
                          _buildInfoRow(
                            context: context,
                            icon: Icons.monetization_on_outlined,
                            label: 'المبلغ المطلوب: ',
                            value:
                                '${advance.requestedAmount?.toStringAsFixed(2) ?? '0.00'} ج.م',
                          ),
                          if (advance.approvedAmount != null) ...[
                            const Gap(8),
                            _buildInfoRow(
                              context: context,
                              icon: Icons.check_circle_outline,
                              label: 'المبلغ المسموح: ',
                              value:
                                  '${advance.approvedAmount?.toStringAsFixed(2) ?? '0.00'} ج.م',
                            ),
                          ],
                          const Gap(8),
                          _buildInfoRow(
                            context: context,
                            icon: Icons.calendar_today_outlined,
                            label: 'تاريخ الطلب: ',
                            value: _formatDate(advance.requestDate.toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            if (advance.status == 'معلقة') ...[
              const Gap(15),
              const Divider(),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 360;

                  final approveButton = ElevatedButton.icon(
                    onPressed: () {
                      _showApproveDialog(context, controller);
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18.spAdaptive(context),
                    ),
                    label: Text(
                      "موافقة",
                      style: cairoStyle(
                        fontcolor: Colors.white,
                        fontSize: 13.spAdaptive(context),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  );

                  final rejectButton = ElevatedButton.icon(
                    onPressed: () {
                      showRejectDialog(context, controller);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18.spAdaptive(context),
                    ),
                    label: Text(
                      "رفض",
                      style: cairoStyle(
                        fontcolor: Colors.white,
                        fontSize: 13.spAdaptive(context),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  );

                  if (isCompact) {
                    return Column(
                      children: [
                        SizedBox(width: double.infinity, child: approveButton),
                        const Gap(10),
                        SizedBox(width: double.infinity, child: rejectButton),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: approveButton),
                      const Gap(10),
                      Expanded(child: rejectButton),
                    ],
                  );
                },
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
      children: [
        Icon(icon, color: Colors.blueGrey, size: 20),
        const Gap(8),
        Text(
          label,
          style: cairoStyle(fontcolor: Colors.grey.shade700, fontSize: 14),
        ),
        Text(
          value,
          style: cairoStyle(fontweight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  void _showApproveDialog(
    BuildContext context,
    AdvanceArchiveController controller,
  ) {
    RxDouble approvedAmount = (advance.requestedAmount ?? 0.0).obs;

    final maxAmount = advance.requestedAmount ?? 5000.0;

    final width = Get.width;
    final height = Get.height;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 Title
                Text(
                  "الموافقة على السلفة",
                  style: cairoStyle(
                    fontSize: width * 0.045,
                    fontweight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: height * 0.02),

                /// 🔹 Label
                Text(
                  "حدد المبلغ المعتمد",
                  style: cairoStyle(fontSize: width * 0.035),
                ),

                SizedBox(height: height * 0.015),

                /// 🔹 Amount Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: height * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  child: Center(
                    child: Text(
                      "${approvedAmount.value.toStringAsFixed(2)} ج.م",
                      style: cairoStyle(
                        fontSize: width * 0.05,
                        fontweight: FontWeight.bold,
                        fontcolor: Colors.blue,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                /// 🔹 Slider
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbColor: Colors.blue,
                    overlayColor: Colors.blue.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: approvedAmount.value,
                    min: 0,
                    max: maxAmount,
                    divisions: maxAmount > 0 ? 100 : 1,
                    label: approvedAmount.value.round().toString(),
                    onChanged: (value) {
                      approvedAmount.value = value;
                    },
                  ),
                ),

                SizedBox(height: height * 0.015),

                /// 🔹 Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                        ),
                        child: Text(
                          "إلغاء",
                          style: cairoStyle(fontSize: width * 0.035),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.approveLoan(advance, approvedAmount.value);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.015,
                          ),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                        ),
                        child: Text(
                          "اعتماد",
                          style: cairoStyle(
                            fontSize: width * 0.035,
                            fontcolor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showRejectDialog(
    BuildContext context,
    AdvanceArchiveController controller,
  ) {
    final width = Get.width;
    final height = Get.height;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔴 Icon
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.red, size: width * 0.08),
              ),

              SizedBox(height: height * 0.02),

              /// 🔹 Title
              Text(
                "تأكيد الرفض",
                style: cairoStyle(
                  fontSize: width * 0.045,
                  fontweight: FontWeight.bold,
                ),
              ),

              SizedBox(height: height * 0.015),

              /// 🔹 Message
              Text(
                "هل أنت متأكد من رفض هذا الطلب؟",
                textAlign: TextAlign.center,
                style: cairoStyle(
                  fontSize: width * 0.035,
                  fontcolor: Colors.grey[700],
                ),
              ),

              SizedBox(height: height * 0.025),

              /// 🔹 Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                      ),
                      child: Text(
                        "لا",
                        style: cairoStyle(fontSize: width * 0.035),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.rejectLoan(advance);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: height * 0.015),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                      ),
                      child: Text(
                        "نعم",
                        style: cairoStyle(
                          fontSize: width * 0.035,
                          fontcolor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
