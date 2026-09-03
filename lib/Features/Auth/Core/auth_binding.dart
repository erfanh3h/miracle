import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';

class AuthBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImp(), fenix: true);
    Get.lazyPut<EntryController>(
      () => EntryController(
        Get.find<AuthRepository>(),
        Get.find<GlobalRepository>(),
      ),
      fenix: true,
    );
  }
}
