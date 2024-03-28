import 'package:miracle/Features/Auth/Core/auth_repository.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Components/timer.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Storage/user_storage_controller.dart';
import 'package:miracle/Features/Audio/Core/audio_binding.dart';
import 'package:miracle/Features/Auth/Core/auth_binding.dart';
import 'package:miracle/Features/General/Core/general_binding.dart';
import 'package:miracle/Features/Review/Core/review_binding.dart';
import 'package:miracle/Features/days/Core/days_binding.dart';

class GlobalBinding implements BindingsInterface {
  @override
  dependencies() => [
        AuthBinding().dependencies(),
        // Get.lazyPut<GlobalController>(
        //   () => GlobalController(Get.find<AuthRepository>()),
        //   fenix: true,
        // ),
        Get.put(UserStoreController()),
        Get.put(GlobalController(Get.find<AuthRepository>())),
        ReviewBinding().dependencies(),
        DaysBinding().dependencies(),
        GeneralBinding().dependencies(),
        AudioBinding().dependencies(),
        Get.lazyPut<GlobalRepository>(() => GlobalRepositoryImp(), fenix: true),
        Get.lazyPut<TimerCompanent>(TimerCompanent.new, fenix: true),
      ];
}
