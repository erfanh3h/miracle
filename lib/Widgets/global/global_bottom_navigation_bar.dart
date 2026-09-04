import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Widgets/app_bottom_bar.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Controllers/home_controller.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';
import 'package:miracle/Widgets/profile_dialog.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  new({super.key});
  final authController = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBottomBar(
        items: [
          AppBottomBarItem(
            title: 'ماجرا',
            icon: Icon(Icons.auto_stories_rounded),
          ),
          AppBottomBarItem(
            title: 'New',
            icon: Icon(Icons.menu_book_rounded),
            isCenter: true, // ← this becomes the big center button
            onTap: () {
              // Handle compose action
            },
          ),
          AppBottomBarItem(
            title: 'پروفایل',
            icon: authController.isPageLoading.value
                ? GlobalLoadingWidget(color: Colors.white, size: 17)
                : Icon(CupertinoIcons.person_alt, size: 23),
            onTap: () {
              if (authController.isPageLoading.value) {
                return;
              }
              ProfileDialog().showDialog();
            },
            isActionOnly: true,
          ),
        ],
        currentIndex: homeController.activeTab.value,
        onChanged: homeController.changeActiveTab,
        borderRadius: 20,
        blurSigma: 10,
        backgroundColor: Colors.white.withValues(alpha: 0.5),
      ),
    );
  }
}
