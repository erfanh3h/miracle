import 'package:flutter/material.dart';
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
    isPageLoading.value = true;
    var result = await _repo.getExperiencesList(page: currentPage);
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
  }

  gotoAddExperience() {
    if (Get.find<GlobalController>().token.isEmpty) {
      Get.toNamed(AppRoutes.entry);
    } else {
      Get.toNamed(AppRoutes.addExperience);
    }
  }
}