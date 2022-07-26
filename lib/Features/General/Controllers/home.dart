import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';

class HomeController extends BaseController {
  @override
  void onInit() {
    Get.find<GlobalController>().fetchUserData();
    super.onInit();
  }
}
