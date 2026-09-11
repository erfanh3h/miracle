import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/delneveshteh_create_controller.dart';
import 'package:miracle/Controllers/delneveshteh_read_controller.dart';

class DelneveshtehAddBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<DelneveshtehCreateController>(
      () => DelneveshtehCreateController(),
      fenix: true,
    );
  }
}

class DelneveshtehReadBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<DelneveshtehReadController>(
      () => DelneveshtehReadController(),
      fenix: true,
    );
  }
}
