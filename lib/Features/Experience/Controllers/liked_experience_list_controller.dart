import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';

class LikedExperienceListController extends BaseController {
  final ExperienceRepository _repo;

  LikedExperienceListController(this._repo);

  int currentPage = 1;
  bool lockPage = false;

  RxList<ExperienceModel> experienceData = RxList([]);
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData({bool resetPage = false}) async {
    if (resetPage) {
      lockPage = false;
      currentPage = 1;
      experienceData.clear();
    }
    if (lockPage) {
      return;
    }
    if (currentPage == 1) {
      isPageLoading.value = true;
    } else {
      isPageLoadingMore.value = true;
    }
    var result = await _repo.getLikedExperiencesList(page: currentPage);
    if (result.resultData != null) {
      final recievedData = result.resultData!;
      if (recievedData.isEmpty) {
        lockPage = true;
      } else {
        experienceData.addAll(recievedData);
        currentPage += 1;
      }
    } else {
      lockPage = true;
    }
    isPageLoading.value = false;
    isPageLoadingMore.value = false;
  }

  gotoAddExperience() {
    Get.toNamed(AppRoutes.addExperience);
  }
}
