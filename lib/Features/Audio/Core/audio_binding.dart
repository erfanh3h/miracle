import 'package:get/get.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';

class AudioBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioController>(
      AudioController.new,
      fenix: true,
    );
  }
}
