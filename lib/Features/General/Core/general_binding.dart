import 'package:refreshed/refreshed.dart';
import 'package:miracle/Features/General/Controllers/home.dart';
import 'package:miracle/Features/General/Controllers/info.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class GeneralBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<HomeController>(
          () => HomeController(),
          fenix: true,
        ),
        Get.lazyPut<InfoController>(
          () => InfoController(
            Get.find<ReviewRepository>(),
          ),
          fenix: true,
        ),
      ];
}
