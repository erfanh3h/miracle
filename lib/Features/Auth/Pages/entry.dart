import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Widgets/global_appbar.dart';
import 'package:miracle/Core/Widgets/input_box.dart';
import 'package:miracle/Core/Widgets/submit_button.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';

class EntryPage extends BaseView<EntryController> {
  EntryPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacings.s20All,
        child: controller.codeSended.value
            ? Column(
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
                    child: InputBox(
                      label: '',
                      controller: controller.codeCtrl,
                      textType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      maxLength: 6,
                    ),
                  ),
                  SizedBox(
                    width: 150.r,
                    child: SubmitButton(
                      tapFunction: controller.submitCode,
                      title: 'ورود',
                    ),
                  )
                ],
              )
            : Column(
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
                    child: InputBox(
                      label: 'برای مثال (9101234567)',
                      controller: controller.phoneCtrl,
                      textType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      maxLength: 10,
                    ),
                  ),
                  SizedBox(
                    width: 150.r,
                    child: SubmitButton(
                      tapFunction: controller.sendCode,
                      title: 'دریافت کد',
                    ),
                  )
                ],
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
