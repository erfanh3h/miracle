import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Core/review_repository.dart';
import 'package:miracle/Widgets/review_dialog.dart';
import 'package:miracle/Controllers/review_controller.dart';

class InfoController extends BaseController {
  final ReviewRepository _reviewRepo;

  late ReviewController reviewController;

  InfoController(this._reviewRepo);

  RxBool letSendReview = RxBool(false);

  @override
  void onInit() {
    reviewController = Get.put(ReviewController(_reviewRepo));
    letSendReview.value = Get.find<AuthController>().userData.value != null;
    super.onInit();
  }

  void addReviewButton() {
    ReviewDialog(
      reviewController,
      label: 'نظر ، پیشنهاد یا انتقاد شما',
      successLabel: 'نظرشماباموفقیت ارسال شد',
    ).showDialog();
  }
}
