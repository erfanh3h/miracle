import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class RegisterController extends BaseController {
  final AuthRepository _repo;

  late DaysModel data;
  late int dataIndex;
  RegisterController(this._repo);

  @override
  void onInit() {
    data = Get.arguments[0];
    dataIndex = Get.arguments[1] - 1;
    super.onInit();
  }
}
