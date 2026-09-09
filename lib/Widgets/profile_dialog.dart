import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Widgets/appwrite_image.dart';

class ProfileDialog {
  final AuthController controller = Get.find<AuthController>();

  void showDialog() {
    final iconColor = Get.overlayContext!.theme.colorScheme.inverseSurface;
    // return;
    if (controller.userData.value == null) {
      controller.login();
    } else {
      Get.dialog(
        SizedBox(
          height: 200,
          child: Center(
            child: Card(
              child: Padding(
                padding: AppSpacings.s50All,
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .center,
                  children: [
                    FadeIn(
                      delay: Duration(milliseconds: 150),
                      child: InkWell(
                        onTap: () {
                          controller.changeAvatar();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          child: controller.avatar.value == null
                              ? Icon(Icons.person)
                              : AppwriteImage(fileId: controller.avatar.value!),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: AppSpacings.s10Horizental,
                      child: FadeIn(
                        delay: Duration(milliseconds: 200),
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              controller.userData.value!.name,
                              style: Get.overlayContext!.textTheme.bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "dastnevis",
                                  ),
                              textDirection: TextDirection.ltr,
                            ),
                            Icon(Icons.person, color: iconColor),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    FadeIn(
                      delay: Duration(milliseconds: 250),
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            controller.userData.value!.email,
                            style: Get.overlayContext!.textTheme.bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "dastnevis",
                                ),
                            textDirection: TextDirection.ltr,
                          ),
                          Icon(Icons.email, color: iconColor),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),
                    FadeIn(
                      delay: Duration(milliseconds: 300),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'خروج',
                            middleText:
                                'آیا برای خروج از حساب کاربری اطمینان دارید؟',
                            middleTextStyle:
                                Get.context!.textTheme.displayMedium,
                            titleStyle: Get.context!.textTheme.displayLarge,
                            actions: [
                              TextButton(
                                onPressed: controller.logout,
                                child: Text(
                                  'بله',
                                  style: Get.context!.textTheme.displaySmall,
                                ),
                              ),
                              TextButton(
                                onPressed: Get.closeDialog,
                                child: Text(
                                  'خیر',
                                  style: Get.context!.textTheme.displaySmall,
                                ),
                              ),
                            ],
                          );
                        },
                        child: Text(
                          "خروج از حساب",
                          style: Get.overlayContext!.textTheme.bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
        // isScrollControlled: true,
      );
    }
  }
}
