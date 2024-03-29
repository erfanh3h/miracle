import 'package:appwrite/appwrite.dart' as ap;
import 'package:flutter/material.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Global/Models/user_model.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:refreshed/refreshed.dart';

class GlobalController extends GetxController {
  final AuthRepository authRepo;
  final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  GlobalController(this.authRepo, this.globalRepo);
  final Rx<UserModel?> _user = Rx(null);
  UserModel? get user => _user.value;
  set user(UserModel? userData) {
    _user.value = userData;
  }

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

  void swapTheme() async {
    if (currentTheme == ThemeMode.dark) {
      Get.changeThemeMode(ThemeMode.light);
      currentTheme = ThemeMode.light;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      currentTheme = ThemeMode.dark;
    }
    await globalRepo.writeIsLightMode(data: currentTheme == ThemeMode.light);
  }

  void changeTheme(bool isLightMode) async {
    if (isLightMode) {
      Get.changeThemeMode(ThemeMode.light);
      currentTheme = ThemeMode.light;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      currentTheme = ThemeMode.dark;
    }
    await globalRepo.writeIsLightMode(data: currentTheme == ThemeMode.light);
  }

  Future<void> readPreTheme() async {
    //save theme base on isDarkMode
    final readResult = await globalRepo.getIsLightMode();
    if (readResult != null) {
      changeTheme(readResult);
    } else {
      changeTheme(true);
    }
  }

  @override
  void onInit() {
    client = ap.Client();
    client
        .setEndpoint(ServerRoutes.appwriteBaseUrl)
        .setProject(ServerRoutes.appwriteProjectId);
    readPreTheme();
    fetchUserData();
    super.onInit();
  }
}
