import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Global/Widgets/global_submit_button.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Review/Controllers/review_controller.dart';

class ReviewDialog extends BaseController {
  final ReviewController reviewController;
  final TextEditingController textController = TextEditingController();

  ReviewDialog(this.reviewController);
  final formKey = GlobalKey<FormState>();

  showDialog() {
    if (Get.find<GlobalController>().token.isEmpty) {
      Get.toNamed(AppRoutes.entry);
    } else {
      Get.bottomSheet(
        Container(
          padding: AppSpacings.s10All,
          height: 200.r,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                GlobalInputBox(
                  label: 'نظر شما',
                  controller: textController,
                  minLines: 4,
                  maxLines: 4,
                  validator: (String value) {
                    if ((value).isEmpty) {
                      return 'این فیلد را پر کنید';
                    }
                    return null;
                  },
                  textType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: 10.r),
                Obx(
                  () => GlobalSubmitButton(
                    tapFunction: () {
                      if (!formKey.currentState!.validate()) return;
                      isPageLoading.value = true;
                      reviewController
                          .sendData(textController.text)
                          .then((value) {
                        isPageLoading.value = false;
                        Get.back();
                      });
                    },
                    title: 'ارسال',
                    isLoading: isPageLoading.value,
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.background,
        // isScrollControlled: true,
      );
    }
  }
}
