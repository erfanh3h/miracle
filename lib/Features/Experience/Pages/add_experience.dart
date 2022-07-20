import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/Experience/Controllers/add_experience_controller.dart';

class AddExperiencePage extends BaseView<AddExperienceController> {
  AddExperiencePage({Key? key}) : super(key: key);

  @override
  bool resizeToAvoidBottomInset() {
    return true;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => ListView(
        children: [
          controller.isVoiceExperience.value
              ? !controller.isRecording.value
                  ? Obx(
                      () => controller.selectedFile.value == null
                          ? Padding(
                              padding: AppSpacings.s20All,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: controller.startRecord,
                                    icon: const Icon(Icons.mic),
                                  ),
                                  // IconButton(onPressed: controller., icon: Icon(Icons.)),
                                  // IconButton(onPressed: controller., icon: Icon(Icons.)),
                                ],
                              ),
                            )
                          : Padding(
                              padding: AppSpacings.s20All,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: controller.startPlay,
                                    icon: const Icon(Icons.play_arrow_rounded),
                                  ),
                                  // IconButton(onPressed: controller., icon: Icon(Icons.)),
                                  // IconButton(onPressed: controller., icon: Icon(Icons.)),
                                ],
                              ),
                            ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 20.r),
                        FadeTransition(
                          opacity: controller.fadeInFadeOut,
                          child: Text(
                            controller.timer.timerLabel.value,
                            style: Get.textTheme.headline2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: controller.stopRecord,
                              icon: const Icon(Icons.square_rounded),
                            ),
                            controller.isRecordingPaused.value
                                ? IconButton(
                                    onPressed: controller.unpauseRecord,
                                    icon: const Icon(Icons.play_arrow_rounded),
                                  )
                                : IconButton(
                                    onPressed: controller.pauseRecord,
                                    icon: const Icon(Icons.pause_rounded),
                                  ),
                            // IconButton(onPressed: controller., icon: Icon(Icons.)),
                          ],
                        ),
                      ],
                    )
              : GestureDetector(
                  onTap: controller.changeImage,
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
                    child: controller.selectedFile.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.memory(
                              controller.selectedFile.value!.bytes!,
                              height: 150.r,
                              width: 150.r,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 150.r,
                            height: 150.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: AppColors.background,
                                size: 50.r,
                              ),
                            ),
                          ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(title: 'افزودن تجربه').build(context);
  }
}
