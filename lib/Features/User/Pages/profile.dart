import 'package:flutter/material.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Auth/Controllers/auth_controller.dart';

class ProfilePage extends BaseView<AuthController> {
  const ProfilePage({super.key});

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      flexibleSpace: Container(
        padding: AppSpacings.s20Top10Right10Left,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: Get.back,
                child: const Padding(
                  padding: AppSpacings.s5All,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    // color: AppColors.white,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'حساب کاربری',
                textDirection: TextDirection.rtl,
                style: context.textTheme.titleMedium,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: Get.find<GlobalController>().swapTheme,
                child: Padding(
                  padding: AppSpacings.s5All,
                  child: Icon(
                    Get.find<GlobalController>().currentTheme.isDark
                        ? Icons.nightlight_round_sharp
                        : Icons.sunny,
                    size: 22,
                    // color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      title: '',
      letBack: false,
    ).build(context);
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: AppSpacings.s10All,
              child: Text(
                'ایمیل',
                style: context.textTheme.bodyLarge,
                textDirection: TextDirection.rtl,
              ),
            ),
            Padding(
              padding: AppSpacings.s10Horizental,
              child: Text(
                controller.userData.value != null
                    ? controller.userData.value!.email
                    : '',
                style: context.textTheme.bodyMedium,
                textDirection: TextDirection.ltr,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.defaultDialog(
          title: 'خروج',
          middleText: 'آیا برای خروج از حساب کاربری اطمینان دارید؟',
          middleTextStyle: Get.context!.textTheme.displayMedium,
          titleStyle: Get.context!.textTheme.displayLarge,
          actions: [
            TextButton(
              onPressed: controller.logout,
              child: Text('بله', style: Get.context!.textTheme.displaySmall),
            ),
            TextButton(
              onPressed: Get.closeAllDialogs,
              child: Text('خیر', style: Get.context!.textTheme.displaySmall),
            ),
          ],
        );
      },
      backgroundColor: AppColors.imageRedColor,
      child: const Icon(Icons.logout, color: AppColors.white),
    );
  }
}
