import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:miracle/Features/User/Controllers/profile.dart';
import 'package:refreshed/refreshed.dart';

class ProfileBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<ProfileController>(
          () => ProfileController(Get.find<AuthRepository>()),
          fenix: true,
        )
      ];
}
