import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Features/Auth/Controllers/auth_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class AuthBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImp(), fenix: true);
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<AuthRepository>(),
        Get.find<GlobalRepository>(),
      ),
      fenix: true,
    );
  }
}
