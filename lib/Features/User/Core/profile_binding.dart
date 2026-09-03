import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:miracle/Features/User/Controllers/profile.dart';
import 'package:getxify/getxify.dart';

class ProfileBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        Get.find<AuthRepository>(),
        Get.find<GlobalRepository>(),
      ),
      fenix: true,
    );
  }
}
