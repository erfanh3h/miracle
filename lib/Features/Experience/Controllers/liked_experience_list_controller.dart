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

// when we go to next page , we most turn this to true to make row widget to rebuild himself,
  // otherwise row widget will not updated if we update favorite value in details screen
  RxList<bool> letShowEachRow = RxList([]);

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
        for (var element in recievedData) {
          letShowEachRow.add(true);
          experienceData.add(element);
        }
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

  // this use to keep update like state when user tap like on list
  reactExperience(int index) {
    experienceData[index] = experienceData[index]
        .copyWith(isLiked: !(experienceData[index].isLiked ?? false));
  }

  goToExperienceDetails(int index) {
    Get.toNamed(
      AppRoutes.experienceDetails,
      arguments: experienceData[index],
    )!
        .then((returnedExperience) async {
      letShowEachRow[index] = false;
      await Future.delayed(const Duration(milliseconds: 30));
      experienceData[index] = experienceData[index]
          .copyWith(isLiked: (returnedExperience.isLiked ?? false));
      letShowEachRow[index] = true;
      experienceData.removeAt(index);
      experienceData.insert(index, returnedExperience);
    });
  }
}
