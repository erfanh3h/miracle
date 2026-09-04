import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/review_controller.dart';

class ReviewBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController(), fenix: true);
  }
}
