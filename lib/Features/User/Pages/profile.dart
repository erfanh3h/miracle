import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/User/Controllers/profile.dart';

class ProfilePage extends BaseView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: AppSpacings.s20All,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              controller.isLoadingImage.value
                  ? SizedBox(
                      height: 175.r,
                      width: 175.r,
                      child: const GlobalLoadingWidget(),
                    )
                  : GestureDetector(
                      onTap: controller.changeImageDialog,
                      child: Container(
                        height: 175.r,
                        width: 175.r,
                        margin: AppSpacings.s10All,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.25,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.primary,
                        ),
                        child: controller.userData.value.imageId != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  ServerRoutes.getFile(
                                    controller.userData.value.imageId!,
                                  ),
                                  height: 125.r,
                                  width: 125.r,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                CupertinoIcons.person_alt,
                                size: 120.r,
                                color: AppColors.white,
                              ),
                      ),
                    ),
              const SizedBox(height: 30),
              controller.letSendUsername.value
                  ? Row(
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
                        controller.isLoadingUsername.value
                            ? const GlobalLoadingWidget()
                            : Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: controller.changeUsername,
                                  icon: Icon(
                                    CupertinoIcons.checkmark_alt,
                                    size: 25.r,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                      ],
                    )
                  : Text(
                      controller.userData.value.username ?? '',
                      style: Get.textTheme.headline4,
                    ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'بافعال کردن این مورد اطلاعات روزهای شمادر سرور ذخیره شده و از بین نمی رود.',
                      textDirection: TextDirection.rtl,
                      style: Get.textTheme.caption,
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
            ],
          ),
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
}
