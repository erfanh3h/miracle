import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class ProfileController extends BaseController {
  final AuthRepository _authRepo;

  ProfileController(this._authRepo);

  TextEditingController usernameCtrl = TextEditingController();
  RxBool letSendUsername = RxBool(false);

  Rx<User> userData = Rx(Get.find<GlobalController>().user!);

  RxBool letSyncDays = RxBool(false);

  RxBool isLoadingImage = RxBool(false);
  RxBool isLoadingUsername = RxBool(false);
  RxBool isLoadingSyncDays = RxBool(false);

  final usernameFormKey = GlobalKey<FormState>();

  getUserData() async {
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
    // Get.offAllNamed(AppRoutes.main);
    // Get.find<GlobalController>().changePage(0);
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
