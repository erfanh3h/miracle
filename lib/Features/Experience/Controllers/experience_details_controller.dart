import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';
import 'package:miracle/Features/Review/Components/review_dialog.dart';
import 'package:miracle/Features/Review/Controllers/review_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ExperienceDetailsController extends BaseController {
  late ExperienceModel data;

  late ReviewController reviewController;
  final ReviewRepository reviewRepo;

  final ScrollController scrollController = ScrollController();

  AudioController? audioController;

  ExperienceDetailsController(this.reviewRepo);

  @override
  void onInit() async {
    try {
      data = Get.arguments;
      reviewController = Get.put(
          ReviewController(reviewRepo, 'experience', data.id!),
          tag: 'experience${data.id}');
      reviewController.getData().then((value) => update());
      if ((data.isVoice ?? false) && data.fileId != null) {
        audioController = Get.find<AudioController>();
        await audioController!
            .setSource(url: ServerRoutes.getFile(data.fileId!));
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
