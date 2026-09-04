import 'package:flutter/material.dart';
import 'package:miracle/Core/Components/dialog_component.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class EntryController extends BaseController {
  final AuthRepository _repo;
  final GlobalRepository _globalRepo;
  EntryController(this._repo, this._globalRepo);

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController rePasswordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  RxBool isLogin = RxBool(true);
  RxBool isRequesting = RxBool(false);

  final registerKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  RxBool isLightMode = RxBool(true);

  Future<void> register() async {
    // if (!registerKey.currentState!.validate()) return;
    isRequesting.value = true;
    var response = await _repo.loginWithGoogle(
      // name: nameCtrl.text,
      // email: emailCtrl.text,
      // password: passwordCtrl.text,
    );
    if (response.resultData != null && response.resultData!) {
      final globalController = Get.find<GlobalController>();
      await globalController.fetchUserData();
      _globalRepo.writeUserEmail(data: emailCtrl.text);
      Get.back();
      DialogCompanent.showToast(
        label: 'حساب شما با موفقیت ایجاد شد.',
        backgroundColor: AppColors.darkGreen,
      );
    } else {}
    isRequesting.value = false;
  }

  Future<void> login() async {
    // if (!loginKey.currentState!.validate()) return;
    isRequesting.value = true;
    var response = await _repo.loginWithGoogle(
      // email: emailCtrl.text,
      // password: passwordCtrl.text,
    );
    if (response.resultData != null) {
      final globalController = Get.find<GlobalController>();
      await globalController.fetchUserData();
      Get.back();
      DialogCompanent.showToast(
        label: 'با موفقیت وارد شدید.',
        backgroundColor: AppColors.darkGreen,
      );
    } else {}
    isRequesting.value = false;
  }

  void changeIsLogin(bool value) {
    isLogin.value = value;
  }

  void changeTheme() {
    final globalController = Get.find<GlobalController>();
    globalController.swapTheme();
    isLightMode.value = !isLightMode.value;
  }

  @override
  void onInit() {
    isLightMode.value =
        Get.find<GlobalController>().currentTheme == ThemeMode.light;
    super.onInit();
  }
}
