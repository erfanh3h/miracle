import 'package:getxify/getxify.dart';
import 'package:miracle/Core/review_repository.dart';

class ReviewBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<ReviewRepository>(() => ReviewRepositoryImp(), fenix: true);
    // Get.lazyPut<ReviewController>(
    //   () => ReviewController(Get.find<ReviewRepository>()),
    //   fenix: true,
    // );
  }
}
