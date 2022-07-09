import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/selectable_bottomsheet.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:miracle/Features/User/Core/user_repository.dart';

class ProfileController extends BaseController {
  final UserRepository _repo;
  final GlobalRepository _globalRepo;
  final AuthRepository _authRepo;

  ProfileController(this._repo, this._globalRepo, this._authRepo);

  TextEditingController usernameCtrl = TextEditingController();
  RxBool letSendUsername = RxBool(false);

  Rx<UserModel> userData = Rx(Get.find<GlobalController>().user!);

  RxBool letSyncDays = RxBool(false);

  RxBool isLoadingImage = RxBool(false);
  RxBool isLoadingUsername = RxBool(false);
  RxBool isLoadingSyncDays = RxBool(false);

  final usernameFormKey = GlobalKey<FormState>();

  getUserData() async {
    isPageLoading.value = true;
    var response = await _repo.getUserData();
    if (response.resultData != null) {
      userData.value = response.resultData!;
      letSyncDays.value = userData.value.saveDayDatas ?? false;
      if (userData.value.username == null) {
        letSendUsername.value = true;
      }
    } else {
      Get.back();
    }
    isPageLoading.value = false;
  }

  changeUsername() async {
    if (!usernameFormKey.currentState!.validate()) return;
    isLoadingUsername.value = true;
    final response = await _repo.changeUsername(username: usernameCtrl.text);
    if (response.resultData != null) {
      userData.value = response.resultData!;
      letSendUsername.value = false;
      Get.offAllNamed(AppRoutes.main);
      ShowMessageCompanent(
        message: 'با موفقیت وارد شدید',
        color: AppColors.green,
      ).show();
    }
    isLoadingUsername.value = false;
  }

  changeDayStatus(bool status) async {
    isLoadingSyncDays.value = true;
    final response = await _repo.changeDayStatus(status: status);
    if (response.resultData != null) {
      letSyncDays.value = status;
      userData.value = response.resultData!;
    }
    isLoadingSyncDays.value = false;
  }

  changeImageDialog() {
    SelectableBottomsheet(
      rawLabels: [
        'انتخاب عکس',
        'حذف عکس',
      ],
      rawIcons: [
        Icons.photo,
        Icons.close,
      ],
      rawFunctions: [
        changeImage,
        deleteUserImage,
      ],
      itemsCount: 2,
    ).show();
  }

  changeImage() async {
    Get.back();
    try {
      var fls = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png', 'webp'],
        allowMultiple: false,
        withData: true,
      );
      isLoadingImage.value = true;
      if (fls!.files.isNotEmpty) {
        var response = await _globalRepo.uploadFile(fileData: fls.files.first);
        if (response.resultData != null) {
          var imageResponse =
              await _repo.setUserImage(imageId: response.resultData!);
          if (imageResponse.resultData != null) {
            userData.value = imageResponse.resultData!;
          } else {}
        } else {}
      }
      isLoadingImage.value = false;
    } catch (_) {}
  }

  deleteUserImage() async {
    Get.back();
    isLoadingImage.value = true;
    final response = await _repo.deleteUserImage();
    if (response.resultData != null) {
      userData.value = response.resultData!;
    }
    isLoadingImage.value = false;
  }

  logout() async {
    Get.back();
    await _authRepo.logout();
    Get.offAllNamed(AppRoutes.main);
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
