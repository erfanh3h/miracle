import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Core/Global/Widgets/app_bottom_bar.dart';
import 'package:miracle/Features/Auth/Controllers/auth_controller.dart';
import 'package:miracle/Features/General/Controllers/home_controller.dart';

class GlobalBottomNavigationBar extends StatelessWidget {
  new({super.key});
  final authController = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> AppBottomBar(
        items: [
          AppBottomBarItem(title: 'Calls', icon: Icon(Icons.call_outlined)),
          AppBottomBarItem(
            title: 'New',
            icon: Icon(Icons.menu_book_rounded),
            isCenter: true, // ← this becomes the big center button
            onTap: () {
              // Handle compose action
            },
          ),
          AppBottomBarItem(
            title: 'Settings',
            icon: Icon(Icons.settings_outlined),
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
