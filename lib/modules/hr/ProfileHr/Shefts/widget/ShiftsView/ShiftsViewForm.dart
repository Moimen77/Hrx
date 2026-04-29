import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/controller/ShiftController.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/widget/EditShift.dart';

class ShiftsViewForm extends GetView<ShiftController> {
  const ShiftsViewForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.employeeTypes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final type = controller.employeeTypes[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.people_alt_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              title: Text(
                type.name,
                style: cairoStyle(
                  fontSize: 16,
                  fontweight: FontWeight.bold,
                  fontcolor: Colors.black87,
                ),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: type.shifts.map((shift) {
                return Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        size: 20,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          shift.name,
                          style: cairoStyle(
                            fontSize: 14,
                            fontweight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${shift.startTime} - ${shift.endTime}",
                            style: cairoStyle(
                              fontSize: 13,
                              fontweight: FontWeight.bold,
                              fontcolor: Colors.blueGrey[700],
                            ),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            onPressed: () {
                              showEditShiftDialog(
                                context: context,
                                shift: shift,
                                controller: controller,
                              );
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                              child: Icon(
                                Icons.edit_rounded,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
