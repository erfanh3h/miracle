import 'package:get/get.dart';
import 'package:miracle/Features/User/Controllers/profile.dart';
import 'package:miracle/Features/User/Core/user_repository.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImp(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        Get.find<UserRepository>(),
      ),
      fenix: true,
    );
  }
}
