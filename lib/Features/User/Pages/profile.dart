import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/User/Controllers/profile.dart';

class ProfilePage extends BaseView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

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
                onTap: controller.changeTheme,
                child: Padding(
                  padding: AppSpacings.s5All,
                  child: Icon(
                    controller.isLightMode.value
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
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: AppSpacings.s10All,
              child: Text(
                'نام',
                style: context.textTheme.bodyLarge,
                textDirection: TextDirection.rtl,
              ),
            ),
            Padding(
              padding: AppSpacings.s10Horizental,
              child: Text(
                controller.userData.value != null
                    ? controller.userData.value!.name ?? ''
                    : '',
                style: context.textTheme.bodyMedium,
                textDirection: TextDirection.ltr,
              ),
            ),
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
                    ? controller.userData.value!.name ?? ''
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
          middleTextStyle: Get.textTheme.displayMedium,
          titleStyle: Get.textTheme.displayLarge,
          actions: [
            TextButton(
              onPressed: controller.logout,
              child: Text('بله', style: Get.textTheme.displaySmall),
            ),
            TextButton(
              onPressed: Get.closeAllDialogs,
              child: Text('خیر', style: Get.textTheme.displaySmall),
            ),
          ],
        );
      },
      backgroundColor: AppColors.error,
      child: const Icon(Icons.logout, color: AppColors.white),
    );
  }
}
