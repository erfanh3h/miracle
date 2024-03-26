import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Experience/Controllers/user_experience_list_controller.dart';
import 'package:miracle/Features/Experience/Widgets/experience_row_widget.dart';

class UserExperienceListPage extends BaseView<UserExperienceListController> {
  const UserExperienceListPage({Key? key}) : super(key: key);
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
    return const GlobalAppbar(title: 'تجربیات من').build(context);
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
