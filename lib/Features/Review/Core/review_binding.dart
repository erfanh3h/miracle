import 'package:refreshed/refreshed.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ReviewBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<ReviewRepository>(
          () => ReviewRepositoryImp(),
          fenix: true,
        )
        // Get.lazyPut<ReviewController>(
        //   () => ReviewController(Get.find<ReviewRepository>()),
        //   fenix: true,
        // );
      ];
}
