import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Components/dialog_component.dart';
import 'package:miracle/Core/review_repository.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Models/review.dart';
import 'package:getxify/getxify.dart';

class ReviewController extends BaseController {
  final ReviewRepository _repo;

  ReviewController(this._repo);

  Future sendData(String review, {String? successLabel}) async {
    isPageLoading.value = true;
    var result = await _repo.sendReview(
      reviewData: ReviewModel(
        review: review,
        userid: Get.find<AuthController>().userData.value!.$id,
      ),
    );
    if (result.resultData != null) {
      DialogCompanent.showToast(
        label: 'ممنون از نظر شما',
        backgroundColor: AppColors.darkGreen,
      );
    }
    isPageLoading.value = false;
  }
}
