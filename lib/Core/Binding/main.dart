import 'package:get/get.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';
import 'package:miracle/Features/General/Core/general_binding.dart';
import 'package:miracle/Features/days/Core/days_binding.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserStoreController());
    DaysBinding().dependencies();
    GeneralBinding().dependencies();
  }
}
