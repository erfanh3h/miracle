import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Review/Components/review_dialog.dart';
import 'package:miracle/Features/Review/Controllers/review_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class InfoController extends BaseController {
  final ReviewRepository _reviewRepo;

  late ReviewController reviewController;

  InfoController(this._reviewRepo);

  RxBool letSendReview = RxBool(false);

  @override
  void onInit() {
    reviewController = Get.put(ReviewController(_reviewRepo));
    letSendReview.value = Get.find<GlobalController>().user != null;
    super.onInit();
  }

  addReviewButton() {
    ReviewDialog(
      reviewController,
      label: 'نظر ، پیشنهاد یا انتقاد شما',
      successLabel: 'نظرشماباموفقیت ارسال شد',
    ).showDialog();
  }
}
