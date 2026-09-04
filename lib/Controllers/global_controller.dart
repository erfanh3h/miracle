import 'package:flutter/material.dart';
import 'package:miracle/Core/global_repository.dart';
import 'package:getxify/getxify.dart';

class GlobalController extends GetxController {
  final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  GlobalController(this.globalRepo);

  RxBool isLoadingProfile = RxBool(true);

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
    readPreTheme();
    super.onInit();
  }
}
