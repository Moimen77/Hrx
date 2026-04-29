import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/Branches_Controller.dart';
import 'package:hrx/routes/app_pages.dart';

class AddBranchDetailsController extends GetxController {
  final BranchesController _branchesController = Get.find<BranchesController>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  late double lat;
  late double lng;
  RxBool isAddingBranch = false.obs;

  @override
  void onInit() {
    super.onInit();

    final Map<String, dynamic> args = Get.arguments;
    lat = args['lat'];
    lng = args['lng'];
  }

  Future<void> onAddBranch(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) return;

      final newBranch = BranchModel(
        name: nameController.text,
        address: addressController.text,
        lat: lat,
        lng: lng,
      );
      isAddingBranch.value = true;
      await _branchesController.addBranch(newBranch);
      AppSnack.success('تم بنجاح', 'تمت إضافة الفرع الجديد بنجاح.');
      Get.offNamed(AppRoutes.home);
    } catch (e) {
      showErrorDialog(
        context,
        'حدث خطأ أثناء إضافة الفرع. يرجى المحاولة مرة أخرى.',
      );
    } finally {
      isAddingBranch.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
