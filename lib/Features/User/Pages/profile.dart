import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
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
                    controller.userData.value != null
                        ? controller.userData.value!.email ?? ''
                        : '',
                    style: Get.textTheme.headlineMedium,
                  ),
            const SizedBox(height: 30),
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
