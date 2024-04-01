import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_submit_button.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';
import 'package:miracle/Features/days/Widgets/change_type_box.dart';
import 'package:refreshed/refreshed.dart';

class EntryPage extends BaseView<EntryController> {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s20All,
        child: controller.isLogin.value
            ? Form(
                key: controller.loginKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: GlobalInputBox(
                        label: 'ایمیل',
                        controller: controller.emailCtrl,
                        textType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        maxLength: 30,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: GlobalInputBox(
                        label: 'رمزعبور',
                        controller: controller.passwordCtrl,
                        textType: TextInputType.text,
                        hideContent: true,
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                        maxLength: 30,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 50.h),
                    ChangeTypeBox(
                      isLogin: controller.isLogin.value,
                      onChangeType: controller.changeIsLogin,
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      width: 150.r,
                      child: GlobalSubmitButton(
                        tapFunction: controller.login,
                        title: 'ورود',
                        isLoading: controller.isRequesting.value,
                      ),
                    )
                  ],
                ),
              )
            : Form(
                key: controller.registerKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: GlobalInputBox(
                        label: 'نام کاربری',
                        controller: controller.nameCtrl,
                        textType: TextInputType.text,
                        textDirection: TextDirection.ltr,
                        maxLength: 15,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          if (value.length < 5) {
                            return 'حداقل 5 حرف را وارد کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: GlobalInputBox(
                        label: 'ایمیل',
                        controller: controller.emailCtrl,
                        textType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        maxLength: 30,
                        onlyEnglishLetters: true,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: GlobalInputBox(
                        label: 'رمزعبور',
                        controller: controller.passwordCtrl,
                        textType: TextInputType.text,
                        hideContent: true,
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                        maxLength: 30,
                        onlyEnglishLetters: true,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: AppSpacings.s20Horizental,
                      child: GlobalInputBox(
                        label: 'تکرار رمزعبور',
                        controller: controller.rePasswordCtrl,
                        textType: TextInputType.text,
                        hideContent: true,
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                        maxLength: 30,
                        onlyEnglishLetters: true,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          if (value != controller.passwordCtrl.text) {
                            return 'تکرار رمز عبور را بدرستی وارد کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 50.h),
                    ChangeTypeBox(
                      isLogin: controller.isLogin.value,
                      onChangeType: controller.changeIsLogin,
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      width: 150.r,
                      child: GlobalSubmitButton(
                        tapFunction: controller.register,
                        title: 'ثبت نام',
                        isLoading: controller.isRequesting.value,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

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
                'ورود',
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
}
