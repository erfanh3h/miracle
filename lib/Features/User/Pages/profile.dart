import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Global/Widgets/global_navigator_button.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/User/Controllers/profile.dart';

class ProfilePage extends BaseView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            controller.letSendUsername.value
                ? Padding(
                    padding: AppSpacings.s20All,
                    child: Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: controller.usernameFormKey,
                            child: GlobalInputBox(
                              label: 'نام کاربری',
                              controller: controller.usernameCtrl,
                              validator: (String value) {
                                if ((value).isEmpty) {
                                  return 'این فیلد را پر کنید';
                                }
                                if (value.length < 3) {
                                  return 'حداقل 3 حرف را وارد کنید';
                                }
                                return null;
                              },
                              onlyEnglishLetters: true,
                              maxLength: 25,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.r),
                      ],
                    ),
                  )
                : Text(
                    controller.userData.value.name,
                    style: Get.textTheme.headlineMedium,
                  ),
            const SizedBox(height: 30),
            Padding(
              padding: AppSpacings.s20Horizental,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'بافعال کردن این مورد اطلاعات روزهای شمادر سرور ذخیره شده و از بین نمی رود.',
                      textDirection: TextDirection.rtl,
                      style: Get.textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(width: 10.r),
                  controller.isLoadingSyncDays.value
                      ? const GlobalLoadingWidget()
                      : Switch(
                          value: controller.letSyncDays.value,
                          onChanged: controller.changeDayStatus,
                        ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Visibility(
              visible: !controller.letSendUsername.value,
              child: GlobalNavigatorButton(
                title: 'تجربیات من',
                icon: Icons.person,
                function: () => Get.toNamed(AppRoutes.userExperienceList),
              ),
            ),
            const SizedBox(height: 5),
            Visibility(
              visible: !controller.letSendUsername.value,
              child: GlobalNavigatorButton(
                title: 'تجربیات موردعلاقه من',
                icon: CupertinoIcons.heart_fill,
                function: () => Get.toNamed(AppRoutes.likedExperienceList),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(
      title: 'حساب کاربری',
    ).build(context);
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.defaultDialog(
          title: 'خروج',
          middleText: 'آیا برای خروج از حساب کاربری اطمینان دارید؟',
          actions: [
            TextButton(
              onPressed: controller.logout,
              child: const Text('بله'),
            ),
            TextButton(
              onPressed: Get.back,
              child: const Text('خیر'),
            ),
          ],
        );
      },
      backgroundColor: AppColors.error,
      child: const Icon(Icons.logout, color: AppColors.white),
    );
  }
}
