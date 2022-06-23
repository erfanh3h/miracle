import 'package:get/get.dart';
import 'package:miracle/Features/General/Controllers/home.dart';

class GeneralBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}
