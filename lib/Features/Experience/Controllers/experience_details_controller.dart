import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';
import 'package:miracle/Features/Review/Components/review_dialog.dart';
import 'package:miracle/Features/Review/Controllers/review_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ExperienceDetailsController extends BaseController {
  late ExperienceModel data;

  late ReviewController reviewController;

  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    try {
      data = Get.arguments;
      reviewController = Get.put(
          ReviewController(
              Get.find<ReviewRepository>(), 'experience', data.id!),
          tag: 'experience${data.id}');
      reviewController.getData().then((value) => update());
      if (data.isVoice ?? false) {
        // _mPlayer.openPlayer();
      }
    } catch (_) {
      Get.back();
    }
    super.onInit();
  }

  void playVoice() async {
    // await _mPlayer.startPlayer(
    //   fromURI: ServerRoutes.getFile(data.fileId!),
    //   codec: Codec.aacMP4,
    //   whenFinished: () {},
    // );
  }

  addReviewButton() {
    ReviewDialog(reviewController).showDialog();
  }
}