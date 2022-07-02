import 'package:get/get.dart';
import 'package:miracle/Features/General/Controllers/home.dart';
import 'package:miracle/Features/General/Core/general_repository.dart';

class GeneralBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<GeneralRepository>(
      () => GeneralRepositoryImp(),
      fenix: true,
    );
  }
}
