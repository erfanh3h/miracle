import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_view.dart';
import 'package:miracle/Components/date_actions.dart';
import 'package:miracle/Controllers/delneveshteh_read_controller.dart';
import 'package:miracle/Models/review.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Widgets/appwrite_image.dart';
import 'package:miracle/Widgets/global/global_appbar.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';

class DelneveshteReadPage extends BaseView<DelneveshtehReadController> {
  const DelneveshteReadPage({super.key});
  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.addReviewButton,
      backgroundColor: Get.context!.theme.colorScheme.primary,
      child: const Icon(Icons.add_comment_rounded, color: AppColors.lightColor),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      title: 'دل نوشته',
      actions: [
        Container(
          alignment: Alignment.center,
          child: controller.isLikeLoading.value
              ? GlobalLoadingWidget(color: AppColors.fontDark, size: 22)
              : InkWell(
                  onTap: controller.changeLikeStatus,
                  child: Padding(
                    padding: AppSpacings.s10All,
                    child: Icon(
                      controller.isLiked.value
                          ? CupertinoIcons.heart_solid
                          : CupertinoIcons.heart,
                      size: 22.r,
                      color: AppColors.fontDark,
                    ),
                  ),
                ),
        ),
      ],
    ).build(context);
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: AppSpacings.s20Horizental10Vertical,
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: AppSpacings.s5All,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.theme.colorScheme.surface,
                    radius: 25,
                    child: controller.data.authorImage == null
                        ? Icon(
                            Icons.person,
                            size: 25,
                            color: context.theme.colorScheme.inverseSurface,
                          )
                        : AppwriteImage(
                            fileId: controller.data.authorImage!,
                            radius: 65,
                          ),
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        controller.data.authorName,
                        style: context.theme.textTheme.headlineLarge,
                      ),
                      Text(
                        controller.data.categoryId,
                        style: context.theme.textTheme.headlineMedium!.copyWith(
                          fontFamily: FontFamilies.delbar,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    DateActionsComponent.toLabel(
                      controller.data.createdAt ?? DateTime.now(),
                    ),
                    style: context.theme.textTheme.headlineLarge!.copyWith(
                      fontFamily: FontFamilies.badkhat,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Card(
            child: Padding(
              padding: AppSpacings.s10All,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Center(
                    child: Text(
                      controller.data.title,
                      style: context.theme.textTheme.headlineLarge!.copyWith(
                        fontFamily: FontFamilies.badkhat,
                        fontSize: 25.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    controller.data.content,
                    style: context.theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 25.h),
          Text(
            "نظرات",
            style: context.theme.textTheme.headlineLarge!.copyWith(
              fontFamily: FontFamilies.gandom,
              fontSize: 17.sp,
            ),
          ),
          SizedBox(height: 5.h),
          if (controller.reviews.isNotEmpty)
            Card(
              child: Padding(
                padding: AppSpacings.s10All,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) =>
                      ReviewRowBox(data: controller.reviews[index]),
                  separatorBuilder: (ctx, index) =>
                      SizedBox(height: 25.h, child: Divider()),
                  itemCount: controller.reviews.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ReviewRowBox extends StatelessWidget {
  const new({super.key, required this.data});

  final ReviewModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '${data.username ?? ""} ${DateActionsComponent.toLabel(data.createdAt ?? DateTime.now())} :',
          style: context.theme.textTheme.headlineSmall!.copyWith(
            fontFamily: FontFamilies.gandom,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          data.content,
          style: context.theme.textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }
}
