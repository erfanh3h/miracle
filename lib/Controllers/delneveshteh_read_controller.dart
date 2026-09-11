import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/delneveshteh_repository.dart';
import 'package:miracle/Core/review_repository.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:getxify/getxify.dart';

class DelneveshtehReadController extends BaseController {
  final DelneveshtehRepository _repo = DelneveshtehRepository();
  final ReviewRepository _reviewRepo = ReviewRepository();

  DelneveshtehReadController();

  late DelneveshtehModel data;

  void addReview() {}
  @override
  void onInit() {
    data = Get.arguments;
    super.onInit();
  }
}
