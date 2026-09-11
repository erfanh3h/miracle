import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Components/dialog_component.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Core/review_repository.dart';
import 'package:miracle/Models/api_result.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Models/review.dart';
import 'package:miracle/Resources/app_consts.dart';

class ReviewController extends BaseController {
  final ReviewRepository _repo = ReviewRepository();

  ReviewController();

  Future sendData({
    required String content,
    required String targetType,
    String targetId = "app",
  }) async {
    isPageLoading.value = true;
    late ApiResult<bool> result;
    if (targetType == ReviewTypes.app) {
      final userData = Get.find<AuthController>().userData.value!;
      final userAvatar = Get.find<AuthController>().avatar.value;
      result = await _repo.sendAppReview(
        reviewData: ReviewModel(
          content: content,
          targetId: targetId,
          targetType: targetType,
          userid: userData.$id,
          username: userData.name,
          userImage: userAvatar,
        ),
      );
    } else {
      result = await _repo.sendReview(
        reviewData: ReviewModel(
          content: content,
          targetId: targetId,
          targetType: targetType,
        ),
      );
    }
    if (result.resultData != null) {
      DialogCompanent.showToast(
        label: 'ممنون از نظر شما',
        backgroundColor: AppColors.darkGreen,
      );
    }
    isPageLoading.value = false;
  }
}
