import 'package:flutter/material.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:refreshed/refreshed.dart';
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

  register() async {
    if (!registerKey.currentState!.validate()) return;
    isRequesting.value = true;
    var response = await _repo.register(
      name: nameCtrl.text,
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );
    if (response.resultData != null && response.resultData!) {
      final globalController = Get.find<GlobalController>();
      await globalController.fetchUserData();
      globalController.userEmail = emailCtrl.text;
      _globalRepo.writeUserEmail(data: emailCtrl.text);
      Get.back();
      ShowMessageCompanent(
              message: 'حساب شما با موفقیت ایجاد شد.', color: AppColors.green)
          .show();
    } else {}
    isRequesting.value = false;
  }

  login() async {
    if (!loginKey.currentState!.validate()) return;
    isRequesting.value = true;
    var response = await _repo.login(
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );
    if (response.resultData != null) {
      final globalController = Get.find<GlobalController>();
      await globalController.fetchUserData();
      globalController.userEmail = emailCtrl.text;
      _globalRepo.writeUserEmail(data: emailCtrl.text);
      Get.back();
      ShowMessageCompanent(
              message: 'با موفقیت وارد شدید.', color: AppColors.green)
          .show();
    } else {}
    isRequesting.value = false;
  }

  changeIsLogin(bool value) {
    isLogin.value = value;
  }

  changeTheme() {
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
