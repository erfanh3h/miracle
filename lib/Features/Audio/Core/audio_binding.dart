import 'package:refreshed/refreshed.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';

class AudioBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<AudioController>(
          AudioController.new,
          fenix: true,
        )
      ];
}
