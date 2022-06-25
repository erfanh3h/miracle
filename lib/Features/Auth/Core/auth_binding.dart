import 'package:get/get.dart';
import 'package:miracle/Features/Auth/Controllers/login.dart';
import 'package:miracle/Features/Auth/Controllers/register.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImp(),
      fenix: true,
    );
    Get.lazyPut<LoginController>(
      () => LoginController(
        Get.find<AuthRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        Get.find<AuthRepository>(),
      ),
      fenix: true,
    );
  }
}
