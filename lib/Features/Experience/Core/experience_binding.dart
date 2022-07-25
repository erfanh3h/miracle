import 'package:get/get.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Features/Experience/Controllers/add_experience_controller.dart';
import 'package:miracle/Features/Experience/Controllers/experience_details_controller.dart';
import 'package:miracle/Features/Experience/Controllers/experience_list_controller.dart';
import 'package:miracle/Features/Experience/Controllers/liked_experience_list_controller.dart';
import 'package:miracle/Features/Experience/Controllers/user_experience_list_controller.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ExperienceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperienceRepository>(
      () => ExperienceRepositoryImp(),
      fenix: true,
    );
    Get.lazyPut<ExperienceListController>(
      () => ExperienceListController(
        Get.find<ExperienceRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<LikedExperienceListController>(
      () => LikedExperienceListController(
        Get.find<ExperienceRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserExperienceListController>(
      () => UserExperienceListController(Get.find<ExperienceRepository>()),
      fenix: true,
    );
    Get.lazyPut<ExperienceDetailsController>(
      () => ExperienceDetailsController(
        Get.find<ReviewRepository>(),
        Get.find<ExperienceRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AddExperienceController>(
      () => AddExperienceController(
        Get.find<ExperienceRepository>(),
        Get.find<GlobalRepository>(),
      ),
      fenix: true,
    );
  }
}
