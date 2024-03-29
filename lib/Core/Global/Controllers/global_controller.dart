import 'package:appwrite/appwrite.dart' as ap;
import 'package:flutter/material.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:refreshed/refreshed.dart';

class GlobalController extends GetxController {
  final AuthRepository authRepo;

  ThemeMode currentTheme = ThemeMode.light;

  GlobalController(this.authRepo);
  final Rx<UserModel?> _user = Rx(null);
  UserModel? get user => _user.value;
  set user(UserModel? userData) {
    _user.value = userData;
  }

  // String get token => _user.value != null ? (_user.value!.token ?? '') : '';

  // bool get syncData =>
  //     _user.value != null ? (_user.value!.saveDayDatas ?? false) : false;

  late ap.Client client;

  RxBool isLoadingProfile = RxBool(true);

  Future<void> fetchUserData() async {
    isLoadingProfile.value = true;
    final result = await authRepo.getActiveUser();
    if (result.resultData != null) {
      user = result.resultData;
    }
    isLoadingProfile.value = false;
    // final storageController = Get.find<UserStoreController>();
    // _user.value = await storageController.getUserData();
    // if (_user.value != null && _user.value!.token != null) {
    //   // if user haven any username he most go profile page
    //   if ((_user.value!.username ?? '') == '') {
    //     return false;
    //   } else {
    //     return true;
    //   }
    // } else {
    //   return true;
    // }
  }

  void changeLanguegue() {
    if ((Get.locale ?? const Locale('en')).languageCode == 'en') {
      Get.updateLocale(const Locale('fa'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }

  void changeTheme() {
    if (currentTheme == ThemeMode.dark) {
      Get.changeThemeMode(ThemeMode.light);
      currentTheme = ThemeMode.light;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      currentTheme = ThemeMode.dark;
    }
  }

  @override
  void onInit() {
    client = ap.Client();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66054f475f92582f7687');
    fetchUserData();
    super.onInit();
  }
}
