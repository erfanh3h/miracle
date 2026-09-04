import 'package:appwrite/appwrite.dart' as ap;
import 'package:flutter/material.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:getxify/getxify.dart';
import 'package:appwrite/models.dart' as models;

class GlobalController extends GetxController {
  final AuthRepository authRepo;
  final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  GlobalController(this.authRepo, this.globalRepo);

  final Rx<models.User?> userData = Rx(null);

  late ap.Client client;

  RxBool isLoadingProfile = RxBool(true);

  Future<void> fetchUserData() async {
    isLoadingProfile.value = true;
    final result = await authRepo.getActiveUser();
    if (result.resultData != null) {
      userData.value = result.resultData;
    }
    isLoadingProfile.value = false;
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
  void onInit() async {
    client = ap.Client();
    client
        .setEndpoint(ServerRoutes.appwriteBaseUrl)
        .setProject(ServerRoutes.appwriteProjectId);
    readPreTheme();
    await fetchUserData();
    super.onInit();
  }
}
