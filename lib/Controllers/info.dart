import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Widgets/review_dialog.dart';

class InfoController extends BaseController {
  InfoController();

  RxBool letSendReview = RxBool(false);

  @override
  void onInit() {
    letSendReview.value = Get.find<AuthController>().userData.value != null;
    super.onInit();
  }

  void addReviewButton() {
    ReviewDialog(
      label: 'نظر ، پیشنهاد یا انتقاد شما',
      successLabel: 'نظرشماباموفقیت ارسال شد',
    ).showDialog();
  }
}
