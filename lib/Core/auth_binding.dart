import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/auth_controller.dart';

class AuthBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
