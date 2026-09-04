import 'package:miracle/Components/timer.dart';
import 'package:miracle/Controllers/home_controller.dart';
import 'package:miracle/Controllers/info.dart';
import 'package:miracle/Core/auth_binding.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/global_controller.dart';
import 'package:miracle/Core/global_repository.dart';
import 'package:miracle/Core/audio_binding.dart';
import 'package:miracle/Core/review_binding.dart';
import 'package:miracle/Core/days_binding.dart';
import 'package:miracle/Core/review_repository.dart';

class GlobalBinding implements Binding {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<GlobalRepository>(() => GlobalRepositoryImp(), fenix: true);
    Get.put(GlobalController(Get.find<GlobalRepository>()));
    ReviewBinding().dependencies();
    DaysBinding().dependencies();
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<InfoController>(
      () => InfoController(Get.find<ReviewRepository>()),
      fenix: true,
    );
    AudioBinding().dependencies();
    Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true);
  }
}
