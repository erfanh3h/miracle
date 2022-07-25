import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Experience/Controllers/liked_experience_list_controller.dart';
import 'package:miracle/Features/Experience/Widgets/experience_row_widget.dart';

class LikedExperienceListPage extends BaseView<LikedExperienceListController> {
  LikedExperienceListPage({Key? key}) : super(key: key);
  @override
  Widget body(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          if (controller.scrollController.position.pixels >
                  controller.scrollController.position.maxScrollExtent - 40.r &&
              !controller.isPageLoadingMore.value &&
              !controller.lockPage) {
            controller.getData();
          }
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          controller.getData(resetPage: true);
        },
        child: ListView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Obx(
                () => Visibility(
                  visible: !controller.isLoadingRow.value,
                  child: ExperienceRowWidget(
                    experience: controller.experienceData[index],
                    onTapFunction: () =>
                        controller.goToExperienceDetails(index),
                  ),
                ),
              ),
              itemCount: controller.experienceData.length,
            ),
          ],
        ),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(title: 'تجربیات موردعلاقه من').build(context);
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.gotoAddExperience,
      child: const Icon(
        CupertinoIcons.add,
        color: AppColors.white,
      ),
    );
  }
}
