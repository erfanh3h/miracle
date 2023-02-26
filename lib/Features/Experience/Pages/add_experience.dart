import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/Audio/Widgets/audio_controll_card.dart';
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
      () => SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.r),
              controller.isVoiceExperience.value
                  ? !controller.isRecording.value
                      ? Obx(
                          () => controller.selectedFile.value == null
                              ? Center(
                                  child: Container(
                                    padding: AppSpacings.s10All,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary,
                                    ),
                                    child: IconButton(
                                      onPressed: controller.startRecord,
                                      icon: const Icon(
                                        Icons.mic,
                                        color: AppColors.white,
                                      ),
                                      color: AppColors.primaryDark,
                                      iconSize: 25.r,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: AppSpacings.s10All,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_rounded,
                                          color: AppColors.error,
                                        ),
                                        iconSize: 35.0,
                                        onPressed: controller.deleteRecord,
                                      ),
                                      Expanded(
                                        child: AudioControllCard(
                                          controller:
                                              controller.audioController!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        )
                      : Padding(
                          padding: AppSpacings.s10All,
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(width: 10.r),
                                FadeTransition(
                                  opacity: controller.fadeInFadeOut,
                                  child: Text(
                                    controller.timer.timerLabel.value,
                                    style: Get.textTheme.headlineMedium,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: controller.stopRecord,
                                  icon: const Icon(
                                    Icons.square_rounded,
                                    color: AppColors.primary,
                                  ),
                                ),
                                controller.isRecordingPaused.value
                                    ? IconButton(
                                        onPressed: controller.unpauseRecord,
                                        icon: const Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColors.primary,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: controller.pauseRecord,
                                        icon: const Icon(
                                          Icons.pause_rounded,
                                          color: AppColors.primary,
                                        ),
                                      ),
                              ],
                            ),
                          ),
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
              Center(
                child: SizedBox(
                  width: 100.r,
                  child: Divider(
                    height: 50.r,
                  ),
                ),
              ),
              Padding(
                padding: AppSpacings.s10Horizental,
                child: GlobalInputBox(
                  label: 'عنوان',
                  controller: controller.titleController,
                  maxLines: 1,
                  validator: (String value) {
                    if ((value).isEmpty) {
                      return 'این فیلد را پر کنید';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15.r),
              Padding(
                padding: AppSpacings.s10Horizental,
                child: GlobalInputBox(
                  label: 'توضیحات',
                  controller: controller.contentController,
                  minLines: 8,
                  // validator: (String value) {
                  //   if ((value).isEmpty) {
                  //     return 'این فیلد را پر کنید';
                  //   }
                  //   return null;
                  // },
                  textType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              Container(
                padding: AppSpacings.s20All,
                margin: AppSpacings.s50Bottom,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'امکان نظرگذاشتن روی تجربه',
                        textDirection: TextDirection.rtl,
                        style: Get.textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(width: 10.r),
                    Switch(
                      value: controller.letAddReview.value,
                      onChanged: controller.changeLetAddReview,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      automaticallyImplyLeading: false,
      flexibleSpace: Obx(
        () => Padding(
          padding: AppSpacings.s20Top10Right10Left,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: Get.back,
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 30.r,
                    color: AppColors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  'افزودن تجربه',
                  // textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontFamily: 'neirizi',
                    color: AppColors.white,
                    fontSize: (16).r,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: controller.changeFileType,
                  child: Icon(
                    controller.isVoiceExperience.value
                        ? Icons.image
                        : Icons.keyboard_voice_rounded,
                    size: 27.r,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      centerTitle: true,
      title: null,
    );
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.sendData,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Icon(
          Icons.send_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}
