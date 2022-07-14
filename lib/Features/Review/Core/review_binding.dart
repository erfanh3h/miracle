import 'package:get/get.dart';
import 'package:miracle/Features/Review/Controllers/experience_details_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewRepository>(
      () => ReviewRepositoryImp(),
      fenix: true,
    );
    Get.lazyPut<ReviewController>(
      () => ReviewController(Get.find<ReviewRepository>()),
      fenix: true,
    );
  }
}
