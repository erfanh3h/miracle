import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';
import 'package:miracle/Features/Review/Models/review.dart';

class ReviewController extends BaseController {
  final ReviewRepository _repo;
  final String _type;
  final int _typeId;
  ReviewController(this._repo, this._type, this._typeId);
  int currentPage = 1;

  List<ReviewModel> reviews = [];

  bool lockPage = false;

  Future<void> getData({bool resetData = false}) async {
    if (resetData) {
      lockPage = false;
      currentPage = 1;
      reviews.clear();
    }
    isPageLoading.value = true;
    var result = await _repo.getReviewsList(
        reviewType: _type, reviewTypeId: _typeId, page: currentPage);
    if (result.resultData != null) {
      final recievedData = result.resultData!;
      if (recievedData.isEmpty) {
        lockPage = true;
      } else {
        reviews.addAll(recievedData);
        currentPage += 1;
        update();
      }
    } else {
      lockPage = true;
    }
    isPageLoading.value = false;
  }

  Future sendData(String review, {String? successLabel}) async {
    isPageLoading.value = true;
    var result = await _repo.sendReview(
      reviewData: ReviewModel(
        review: review,
        reviewType: _type,
        reviewTypeId: _typeId,
      ),
    );
    if (result.resultData != null) {
      ShowMessageCompanent(
        message: successLabel ?? 'نظرشما ثبت و پس از بازبینی منتشر می شود',
        color: AppColors.green,
      ).show();
    }
    isPageLoading.value = false;
  }
}
