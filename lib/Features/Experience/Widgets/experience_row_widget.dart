import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Components/date_actions.dart';
import 'package:miracle/Core/Global/Widgets/global_reactioner_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_images.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';

class ExperienceRowWidget extends StatelessWidget {
  const ExperienceRowWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final ExperienceModel experience;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s10All,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: AppSpacings.s5All,
              height: 100.r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          experience.title ?? '',
                          textDirection: TextDirection.rtl,
                          style:
                              Get.textTheme.headline2!.copyWith(fontSize: 18.r),
                        ),
                      ),
                      GlobalReactionerWidget(
                        initalValue: experience.isLiked ?? false,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        experience.content ?? '',
                        textDirection: TextDirection.rtl,
                        style: Get.textTheme.headline3!.copyWith(
                          fontSize: 12.r,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          experience.userName ?? '',
                          textDirection: TextDirection.rtl,
                          style: Get.textTheme.caption!.copyWith(
                            color: AppColors.grey500,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateActionsComponent(date: experience.createDate)
                            .toJalali(),
                        style: Get.textTheme.caption!.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          !(experience.isVoice ?? false)
              ? experience.fileId == null
                  ? Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: AppColors.background,
                          size: 50.r,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.network(
                        ServerRoutes.getFile(
                          experience.fileId!,
                        ),
                        width: 100.r,
                        height: 100.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => Image.asset(
                          AppImages.imagePlaceHolder,
                          width: 100.r,
                          height: 100.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
              : Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.music_note,
                      color: AppColors.background,
                      size: 50.r,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
