import 'package:flutter/material.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Components/dialog_component.dart';
import 'package:miracle/Core/delneveshteh_repository.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:getxify/getxify.dart';

class DelneveshtehCreateController extends BaseController {
  final DelneveshtehRepository _repo = DelneveshtehRepository();

  DelneveshtehCreateController();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();

  RxString categoryIdController = RxString("");

  RxBool letReview = RxBool(true);

  void changeCategoryId(String? data) {
    categoryIdController.value = data ?? "";
  }

  Future onCreateTap() async {
    if (isPageLoading.value) {
      return;
    }
    isPageLoading.value = true;
    final userData = Get.find<AuthController>().userData.value!;
    final userAvatar = Get.find<AuthController>().avatar.value;
    var result = await _repo.writeDataServer(
      delData: DelneveshtehModel(
        title: titleCtrl.text,
        content: contentCtrl.text,
        categoryId: categoryIdController.value,
        authorId: userData.$id,
        letReview: true,
        authorName: userData.name,
        authorImage: userAvatar,
      ),
    );
    if (result.resultData != null) {
      DialogCompanent.showToast(
        label: 'دل نوشته شما ثبت شد',
        backgroundColor: AppColors.darkGreen,
      );
      Get.back();
    }
    isPageLoading.value = false;
  }
}
