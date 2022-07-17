import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';
import 'package:miracle/Features/Review/Controllers/review_controller.dart';

class ExperienceDetailsController extends BaseController {
  late ExperienceModel data;

  late ReviewController reviewController;
  @override
  void onInit() {
    try {
      data = Get.arguments;
      reviewController = Get.put(
          ReviewController(type: 'experience', typeId: data.id!),
          tag: 'experience${data.id}');
      reviewController.getData();
    } catch (_) {
      Get.back();
    }
    super.onInit();
  }
}
