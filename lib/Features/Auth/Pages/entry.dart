import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_submit_button.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';
import 'package:miracle/Features/days/Widgets/change_type_box.dart';

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
                    SizedBox(height: 50.h),
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
                    SizedBox(height: 50.h),
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
    return const GlobalAppbar(title: 'ورود').build(context);
  }
}
