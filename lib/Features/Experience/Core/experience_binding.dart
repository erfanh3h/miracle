import 'package:get/get.dart';
import 'package:miracle/Features/Experience/Controllers/add_experience_controller.dart';
import 'package:miracle/Features/Experience/Controllers/experience_details_controller.dart';
import 'package:miracle/Features/Experience/Controllers/experience_list_controller.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';

class ExperienceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperienceRepository>(
      () => ExperienceRepositoryImp(),
      fenix: true,
    );
    Get.lazyPut<ExperienceListController>(
      () => ExperienceListController(Get.find<ExperienceRepository>()),
      fenix: true,
    );
    Get.lazyPut<ExperienceDetailsController>(
      () => ExperienceDetailsController(Get.find<ExperienceRepository>()),
      fenix: true,
    );
    Get.lazyPut<AddExperienceController>(
      () => AddExperienceController(Get.find<ExperienceRepository>()),
      fenix: true,
    );
  }
}
