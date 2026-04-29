import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/Branches_Controller.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/widget/BranchView/ListBranchCard.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/repo/Branches_Repo.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/services/Branches_servicesSupabase.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class BranchesScreen extends StatelessWidget {
  final controller = Get.put(
    BranchesController(BranchesRepository(BranchesSupabaseService())),
  );
  BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'إدارة الفروع'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (controller.isLoading.value) {
            return Loadingcircular();
          }
          if (controller.branches.isEmpty) {
            return Center(
              child: Text(
                'لا توجد فروع مضافة حاليًا.',
                style: cairoStyle(fontSize: 16, fontcolor: Colors.grey),
              ),
            );
          }
          return ListBranchCard();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addBranch);
        },
        child: const Icon(Icons.add),
        tooltip: 'إضافة فرع جديد',
      ),
    );
  }
}
