import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';
import 'package:miracle/Features/Review/Components/review_dialog.dart';
import 'package:miracle/Features/Review/Controllers/review_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ExperienceDetailsController extends BaseController {
  late ExperienceModel data;

  late ReviewController reviewController;
  final ReviewRepository _reviewRepo;
  final ExperienceRepository _experienceRepo;

  final ScrollController scrollController = ScrollController();

  AudioController? audioController;

  ExperienceDetailsController(this._reviewRepo, this._experienceRepo);

  RxBool isLiked = RxBool(false);

  @override
  void onInit() async {
    try {
      data = Get.arguments;
      isLiked.value = data.isLiked ?? false;
      reviewController = Get.put(
          ReviewController(_reviewRepo, 'experience', data.id!),
          tag: 'experience${data.id}');
      reviewController.getData().then((value) => update());
      if ((data.isVoice ?? false) && data.fileId != null) {
        audioController = Get.find<AudioController>();
        await audioController!
            .setSource(url: ServerRoutes.getFile(data.fileId!));
      }
    } catch (_) {
      Get.back();
      ShowMessageCompanent(
        message: 'خطا در دریافت اطلاعات این تجربه!',
        color: AppColors.error,
      );
    }
    super.onInit();
  }

  changeReaction() {
    isLiked.value = !isLiked.value;
  }

  backPage() async{
    if (audioController != null) await audioController!.stop();
    Get.back(result: data.copyWith(isLiked: isLiked.value));
  }

  addReviewButton() {
    ReviewDialog(reviewController).showDialog();
  }

  deleteExperience() async {
    Get.defaultDialog(
      title: 'حذف',
      middleText: 'آیا برای حذف این تجربه اطمینان دارید؟',
      actions: [
        TextButton(
          onPressed: () async {
            isPageLoading.value = true;
            await _experienceRepo.deleteExperience(dataId: data.id!);
            Get.back();
            ShowMessageCompanent(
              message: 'تجربه با موفقیت حذف شد',
              color: AppColors.green,
            ).show();
            Get.back(result: true);
          },
          child: const Text('بله'),
        ),
        TextButton(
          onPressed: Get.back,
          child: const Text('خیر'),
        ),
      ],
    );
  }
}
