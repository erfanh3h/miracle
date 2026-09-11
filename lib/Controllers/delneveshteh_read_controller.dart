import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/delneveshteh_repository.dart';
import 'package:miracle/Core/review_repository.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Models/review.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Widgets/review_dialog.dart';

class DelneveshtehReadController extends BaseController {
  final DelneveshtehRepository _repo = DelneveshtehRepository();
  final ReviewRepository _reviewRepo = ReviewRepository();

  DelneveshtehReadController();

  late DelneveshtehModel data;

  RxList<ReviewModel> reviews = RxList([]);
  RxBool isLiked = RxBool(false);
  RxBool isLikeLoading = RxBool(false);

  void addReviewButton() {
    ReviewDialog(
      label: 'نظر شما',
      successLabel: 'نظرشماباموفقیت ارسال شد',
    ).showDialog(reviewType: ReviewTypes.delneveshteh, targetId: data.id);
  }

  Future<void> readReviews() async {
    final result = await _reviewRepo.readReviews(
      targetId: data.id!,
      targetType: ReviewTypes.delneveshteh,
    );
    if (result.resultData != null) {
      reviews.addAll(result.resultData!);
    }
  }

  Future<void> checkIsLiked() async {
    isLikeLoading.value = true;
    final result = await _repo.isDelneveshteLiked(delId: data.id!);

    isLiked.value = result.resultData ?? false;
    isLikeLoading.value = false;
  }

  Future<void> changeLikeStatus() async {
    isLikeLoading.value = true;
    // isLiked.value = !isLiked.value;
    final result = await _repo.toggleDelneveshteLike(delId: data.id!);

    isLiked.value = (result.resultData ?? false);
    isLikeLoading.value = false;
  }

  @override
  void onInit() {
    data = Get.arguments;
    readReviews();
    checkIsLiked();
    super.onInit();
  }
}
