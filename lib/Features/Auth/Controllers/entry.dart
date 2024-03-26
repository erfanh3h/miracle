import 'package:flutter/cupertino.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class EntryController extends BaseController {
  final AuthRepository _repo;
  EntryController(this._repo);

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  RxBool codeSended = RxBool(false);

  final phoneKey = GlobalKey<FormState>();
  final codeKey = GlobalKey<FormState>();

  sendCode() async {
    if (!phoneKey.currentState!.validate()) return;
    isPageLoading.value = true;
    var response = await _repo.enterPhone(phone: phoneCtrl.text);
    if (response.resultData != null) {
      codeSended.value = true;
    } else {}
    isPageLoading.value = false;
  }

  submitCode() async {
    if (!codeKey.currentState!.validate()) return;
    isPageLoading.value = true;
    var response = await _repo.sendCode(
      phone: phoneCtrl.text,
      code: codeCtrl.text,
    );
    if (response.resultData != null) {
      if (response.resultData!.username == null) {
        Get.offNamed(AppRoutes.profile);
      } else {
        ShowMessageCompanent(
          message: 'با موفقیت وارد شدید',
          color: AppColors.green,
        ).show();
        Get.offAllNamed(AppRoutes.main);
        Get.find<GlobalController>().changePage(0);
      }
    } else {}
    isPageLoading.value = false;
  }
}
