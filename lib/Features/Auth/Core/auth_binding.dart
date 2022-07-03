import 'package:get/get.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';
import 'package:miracle/Features/Auth/Controllers/register.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImp(),
      fenix: true,
    );
    Get.lazyPut<EntryController>(
      () => EntryController(
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
