import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_submit_button.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';

class EntryPage extends BaseView<EntryController> {
  EntryPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s20All,
        child: controller.codeSended.value
            ? Form(
                key: controller.codeKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'کد دریافتی را وارد کنید',
                        style: Get.textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: AppSpacings.s10Top20Bot,
                      child: GlobalInputBox(
                        label: '',
                        controller: controller.codeCtrl,
                        textType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        maxLength: 6,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          if (value.length != 6) {
                            return 'کد خودرا بدرستی وارد کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150.r,
                      child: GlobalSubmitButton(
                        tapFunction: controller.submitCode,
                        title: 'ورود',
                      ),
                    )
                  ],
                ),
              )
            : Form(
                key: controller.phoneKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'شماره تماس خود را برای ورود به حساب وارد کنید',
                        style: Get.textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: AppSpacings.s10Top20Bot,
                      child: GlobalInputBox(
                        label: 'برای مثال (9101234567)',
                        controller: controller.phoneCtrl,
                        textType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        maxLength: 10,
                        validator: (String value) {
                          if ((value).isEmpty) {
                            return 'این فیلد را پر کنید';
                          }
                          if (value.length != 10) {
                            return 'شماره خودرا بدرستی وارد کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150.r,
                      child: GlobalSubmitButton(
                        tapFunction: controller.sendCode,
                        title: 'دریافت کد',
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
    return const GlobalAppbar(
      title: 'ورود',
      fontsize: 20,
    ).build(context);
  }
}
