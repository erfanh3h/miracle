import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Widgets/global/global_input_box.dart';
import 'package:miracle/Widgets/global/global_submit_button.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Routes/app_routes.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Controllers/review_controller.dart';

class ReviewDialog extends BaseController {
  final ReviewController reviewController = Get.find<ReviewController>();
  final TextEditingController textController = TextEditingController();
  final String? label;
  final String? successLabel;
  ReviewDialog({this.label, this.successLabel});
  final formKey = GlobalKey<FormState>();

  void showDialog() {
    if (Get.find<AuthController>().userData.value == null) {
      Get.toNamed(AppRoutes.entry);
    } else {
      Get.dialog(
        SizedBox(
          height: 250,
          child: Center(
            child: Card(
              child: Padding(
                padding: AppSpacings.s20All,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Text("ارتباط با ادمین"),
                    const SizedBox(height: 15),
                    GlobalInputBox(
                      label: label ?? 'نظر شما',
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
                          if (textController.text.isEmpty) return;
                          isPageLoading.value = true;
                          reviewController
                              .sendData(
                                textController.text,
                                successLabel: successLabel,
                              )
                              .then((value) {
                                isPageLoading.value = false;
                                Get.back();
                              });
                        },
                        title: 'ارسال',
                        isLoading: isPageLoading.value,
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
