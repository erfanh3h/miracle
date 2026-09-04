import 'package:miracle/Components/timer.dart';
import 'package:miracle/Controllers/home_controller.dart';
import 'package:miracle/Controllers/info.dart';
import 'package:miracle/Core/auth_binding.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/global_controller.dart';
import 'package:miracle/Core/audio_binding.dart';
import 'package:miracle/Core/review_binding.dart';

class GlobalBinding implements Binding {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.put(GlobalController());
    ReviewBinding().dependencies();
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<InfoController>(() => InfoController(), fenix: true);
    AudioBinding().dependencies();
    Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true);
  }
}
