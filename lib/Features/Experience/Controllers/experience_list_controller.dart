import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';

class ExperienceListController extends BaseController {
  final ExperienceRepository _repo;

  ExperienceListController(this._repo);

  int currentPage = 1;
  bool lockPage = false;

  List<ExperienceModel> experienceData = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    if (lockPage) {
      return;
    }
    isPageLoading.value = true;
    var result = await _repo.getExperiencesList(page: currentPage);
    if (result.resultData != null) {
      experienceData.addAll(result.resultData!);
    } else {
      lockPage = true;
    }
    isPageLoading.value = false;
  }

  gotoAddExperience() {
    if (Get.find<GlobalController>().token.isEmpty) {
      Get.toNamed(AppRoutes.entry);
    } else {
      Get.toNamed(AppRoutes.addExperience);
    }
  }
}
