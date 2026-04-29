import 'package:flutter/material.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/widget/AddBranch/Location/AddLoacationMap.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/widget/AddBranch/Location/floatingActionButtonLocation.dart'
    as fab;
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddBranchLocationView extends StatelessWidget {
  const AddBranchLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'أضافة فرع جديد'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: fab.FloatingActionButtonLocation(),
      body: SafeArea(child: AddLoacationMap()),
    );
  }
}
