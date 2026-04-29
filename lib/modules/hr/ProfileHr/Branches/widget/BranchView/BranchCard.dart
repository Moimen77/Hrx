import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/Branches_Controller.dart';

class BranchCard extends GetView<BranchesController> {
  const BranchCard({super.key, required this.branch});
  final BranchModel branch;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: h * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(w * 0.03),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: h * 0.015,
          horizontal: w * 0.04,
        ),
        leading: Icon(
          Icons.apartment_rounded,
          color: Colors.blueAccent,
          size: w * 0.08,
        ),
        title: Text(
          branch.name,
          style: cairoStyle(fontweight: FontWeight.bold, fontSize: w * 0.04),
        ),
        subtitle: Text(
          branch.address,
          style: cairoStyle(fontcolor: Colors.black54, fontSize: w * 0.03),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red, size: w * 0.07),
          onPressed: () => controller.deleteBranch(branch.id!),
        ),
      ),
    );
  }
}
