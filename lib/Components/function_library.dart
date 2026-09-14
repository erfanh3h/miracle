import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/auth_controller.dart';

class FunctionLibrary {
  static Future<bool> isLoggedIn({bool showLoginBox = true}) async {
    bool result = Get.find<AuthController>().isLoggedIn();
    if (result) {
      return true;
    } else {
      if (showLoginBox) {
        await Get.find<AuthController>().login();
        return isLoggedIn();
      } else {
        return false;
      }
    }
  }
}
