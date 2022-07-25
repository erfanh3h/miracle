import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Components/date_actions.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Global/Widgets/global_reactioner_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Audio/Widgets/audio_controll_card.dart';
import 'package:miracle/Features/Experience/Controllers/experience_details_controller.dart';
import 'package:miracle/Features/Review/Widgets/review_row.dart';

class ExperienceDetailsPage extends BaseView<ExperienceDetailsController> {
  ExperienceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          if (controller.scrollController.position.pixels >
                  controller.scrollController.position.maxScrollExtent - 40.r &&
              !controller.reviewController.isPageLoading.value &&
              !controller.reviewController.lockPage) {
            controller.reviewController.getData();
          }
        }
        return true;
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller.scrollController,
        children: [
          SizedBox(height: 20.r),
          !(controller.data.isVoice ?? false)
              ? controller.data.fileId == null
                  ? Center(
                      child: Container(
                        width: 200.r,
                        height: 200.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: AppColors.background,
                            size: 100.r,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.network(
                          ServerRoutes.getFile(
                            controller.data.fileId!,
                          ),
                          width: 200.r,
                          height: 200.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Container(
                            width: 200.r,
                            height: 200.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: AppColors.background,
                                size: 100.r,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
              : Center(
                  child: Padding(
                    padding: AppSpacings.s10All,
                    child: AudioControllCard(
                      controller: controller.audioController!,
                    ),
                  ),
                ),
          SizedBox(height: 10.r),
          Padding(
            padding: AppSpacings.s10All,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.data.title ?? '',
                    textDirection: TextDirection.rtl,
                    style: Get.textTheme.headline2!.copyWith(fontSize: 20.r),
                  ),
                ),
                (controller.data.isMyExperience ?? false)
                    ? Icon(
                        controller.data.isAccepted!
                            ? Icons.check_box_rounded
                            : Icons.hourglass_top_rounded,
                        color: controller.data.isAccepted!
                            ? AppColors.green
                            : AppColors.yellow,
                        size: 25.r,
                      )
                    : GlobalReactionerWidget(
                        initalValue: controller.isLiked.value,
                        reactionType: 'experience',
                        reactionTypeId: controller.data.id!,
                        onTapFunction: controller.changeReaction,
                      ),
              ],
            ),
          ),
          Padding(
            padding: AppSpacings.s10Horizental,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.person_pin_outlined,
                  color: AppColors.primary,
                  size: 20.r,
                ),
                Text(
                  controller.data.userName ?? '',
                  textDirection: TextDirection.rtl,
                  style: Get.textTheme.caption!.copyWith(
                    color: AppColors.grey500,
                  ),
                  maxLines: 1,
                ),
                SizedBox(width: 10.r),
                Icon(
                  CupertinoIcons.calendar,
                  color: AppColors.primary,
                  size: 20.r,
                ),
                Text(
                  DateActionsComponent(date: controller.data.createDate)
                      .toJalali(),
                  style:
                      Get.textTheme.caption!.copyWith(color: AppColors.grey500),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppSpacings.s10All,
            child: Text(
              controller.data.content ?? '',
              textDirection: TextDirection.rtl,
              style: Get.textTheme.bodyText1,
            ),
          ),
          Center(
            child: SizedBox(
              width: 100.r,
              child: Divider(
                height: 50.r,
              ),
            ),
          ),
          Padding(
            padding: AppSpacings.s10All,
            child: Text(
              'نظرات کاربران',
              textDirection: TextDirection.rtl,
              style: Get.textTheme.headline2!.copyWith(fontSize: 20.r),
            ),
          ),
          SizedBox(height: 10.r),
          controller.reviewController.isPageLoading.value
              ? const GlobalLoadingWidget(size: 20)
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ReviewRow(
                      review: controller.reviewController.reviews[index]),
                  itemCount: controller.reviewController.reviews.length,
                ),
          SizedBox(height: 50.r),
        ],
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
            title: !(controller.data.isMyExperience ?? false)
                ? 'تجربه'
                : 'تجربه من')
        .build(context);
  }

  @override
  Widget? floatingActionButton() {
    return (controller.data.letReview ?? true)
        ? FloatingActionButton(
            onPressed: controller.addReviewButton,
            child: const Icon(
              Icons.add_comment,
              color: AppColors.white,
            ),
          )
        : null;
  }

  @override
  Future<bool> onWillPop(BuildContext context) {
    return controller.backPage();
  }
}
