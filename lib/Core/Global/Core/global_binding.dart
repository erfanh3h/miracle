import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';
import 'package:miracle/Features/Auth/Core/auth_binding.dart';
import 'package:miracle/Features/Experience/Core/experience_binding.dart';
import 'package:miracle/Features/General/Core/general_binding.dart';
import 'package:miracle/Features/Review/Core/review_binding.dart';
import 'package:miracle/Features/User/Core/user_binding.dart';
import 'package:miracle/Features/days/Core/days_binding.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserStoreController());
    Get.put(GlobalController());
    AuthBinding().dependencies();
    DaysBinding().dependencies();
    GeneralBinding().dependencies();
    UserBinding().dependencies();
    ExperienceBinding().dependencies();
    ReviewBinding().dependencies();
    Get.lazyPut<GlobalRepository>(
      () => GlobalRepositoryImp(),
      fenix: true,
    );
  }
}
