import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';
import 'package:miracle/Features/Review/Models/review.dart';

class ReviewController extends BaseController {
  final ReviewRepository _repo = Get.find<ReviewRepository>();
  final String type;
  final int typeId;
  ReviewController({required this.type, required this.typeId});
  int currentPage = 1;

  List<ReviewModel> reviews = [];

  bool lockPage = false;

  getData() async {
    isPageLoading.value = true;
    var result = await _repo.getReviewsList(
        reviewType: type, reviewTypeId: typeId, page: currentPage);
    if (result.resultData != null) {
      reviews.addAll(result.resultData!);
    } else {
      lockPage = true;
    }
    isPageLoading.value = false;
  }
}
