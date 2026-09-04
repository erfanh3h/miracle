import 'package:miracle/Core/global_repository.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Core/auth_repository.dart';

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
