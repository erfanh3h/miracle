import 'package:get/get.dart';
import 'package:miracle/Features/days/Controllers/days.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';

class DaysPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaysController>(
      () => DaysController(
        Get.find<DaysRepository>(),
      ),
      fenix: true,
      tag: Get.arguments.toString(),
    );
  }
}
