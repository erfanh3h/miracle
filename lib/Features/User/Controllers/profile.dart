import 'package:flutter/material.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class ProfileController extends BaseController {
  final AuthRepository _authRepo;
  final GlobalRepository _globalRepo;

  ProfileController(this._authRepo, this._globalRepo);

  Rx<String?> userId = Rx(Get.find<GlobalController>().userId);
  Rx<String?> userEmail = Rx(Get.find<GlobalController>().userEmail);

  final usernameFormKey = GlobalKey<FormState>();

  RxBool isLightMode = RxBool(true);

  getUserData() async {
    final globalContorller = Get.find<GlobalController>();
    userId.value = globalContorller.userId;
    userEmail.value = globalContorller.userEmail;
    isLightMode.value = globalContorller.currentTheme == ThemeMode.light;
    // isPageLoading.value = true;
    // var response = await _repo.getUserData();
    // if (response.resultData != null) {
    //   userData.value = response.resultData!;
    //   letSyncDays.value = userData.value.saveDayDatas ?? false;
    //   if (userData.value.username == null) {
    //     letSendUsername.value = true;
    //   }
    // } else {
    //   Get.back();
    // }
    // isPageLoading.value = false;
  }

  changeDayStatus(bool status) async {
    // isLoadingSyncDays.value = true;
    // final response = await _repo.changeDayStatus(status: status);
    // if (response.resultData != null) {
    //   letSyncDays.value = status;
    //   userData.value = response.resultData!;
    // }
    // isLoadingSyncDays.value = false;
  }

  logout() async {
    Get.back();
    await _authRepo.logout();
    _globalRepo.logoutRemoveData();
    // Get.offAllNamed(AppRoutes.main);
    // Get.find<GlobalController>().changePage(0);
  }

  changeTheme() {
    final globalController = Get.find<GlobalController>();
    globalController.swapTheme();
    isLightMode.value = !isLightMode.value;
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
