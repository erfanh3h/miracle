import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/User/Core/user_repository.dart';

class ProfileController extends BaseController {
  final UserRepository _repo;

  ProfileController(this._repo);

  @override
  void onInit() {
    super.onInit();
  }
}
