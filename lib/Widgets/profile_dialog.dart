import 'package:flutter/material.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Widgets/appwrite_image.dart';

class ProfileDialog {
  final AuthController controller = Get.find<AuthController>();

  void showDialog() {
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
                  children: [
                    const SizedBox(height: 15),
                    InkWell(
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
                    const SizedBox(height: 15),
                    Padding(
                      padding: AppSpacings.s10Horizental,
                      child: Text(
                        controller.userData.value!.name,
                        style: Get.overlayContext!.textTheme.bodyMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "dastnevis",
                            ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    Text(
                      controller.userData.value!.email,
                      style: Get.overlayContext!.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: "dastnevis",
                      ),
                      textDirection: TextDirection.ltr,
                    ),

                    const SizedBox(height: 30),
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'خروج',
                          middleText:
                              'آیا برای خروج از حساب کاربری اطمینان دارید؟',
                          middleTextStyle: Get.context!.textTheme.displayMedium,
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
                      icon: Icon(
                        Icons.logout,
                        color: Get
                            .overlayContext!
                            .theme
                            .colorScheme
                            .inverseSurface,
                      ),
                    ),
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
