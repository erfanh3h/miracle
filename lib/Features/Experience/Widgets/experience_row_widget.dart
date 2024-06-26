import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Components/date_actions.dart';
import 'package:miracle/Core/Global/Widgets/global_reactioner_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';

class ExperienceRowWidget extends StatefulWidget {
  const ExperienceRowWidget({
    Key? key,
    required this.experience,
    required this.onTapFunction,
    this.onLikeTap,
  }) : super(key: key);

  final ExperienceModel experience;
  final VoidCallback onTapFunction;
  final VoidCallback? onLikeTap;

  @override
  State<ExperienceRowWidget> createState() => _ExperienceRowWidgetState();
}

class _ExperienceRowWidgetState extends State<ExperienceRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s10All,
      child: InkWell(
        onTap: widget.onTapFunction,
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
                            widget.experience.title ?? '',
                            textDirection: TextDirection.rtl,
                            style: Get.textTheme.displayMedium!
                                .copyWith(fontSize: 18.r),
                          ),
                        ),
                        (widget.experience.isMyExperience ?? false)
                            ? Icon(
                                widget.experience.isAccepted!
                                    ? Icons.check_box_rounded
                                    : Icons.hourglass_top_rounded,
                                color: widget.experience.isAccepted!
                                    ? AppColors.green
                                    : AppColors.yellow,
                                size: 20.r,
                              )
                            : GlobalReactionerWidget(
                                initalValue: widget.experience.isLiked ?? false,
                                reactionType: 'experience',
                                reactionTypeId: widget.experience.id!,
                                onTapFunction: widget.onLikeTap,
                              ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.experience.content ?? '',
                          textDirection: TextDirection.rtl,
                          style: Get.textTheme.displaySmall!.copyWith(
                            fontSize: 12.r,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20.r,
                          height: 20.r,
                          margin: AppSpacings.s5All,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.r),
                            child: widget.experience.userImage != null
                                ? Image.network(
                                    ServerRoutes.getFile(
                                      widget.experience.userImage!,
                                    ),
                                    width: 20.r,
                                    height: 20.r,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, _, __) => Icon(
                                      CupertinoIcons.person_alt,
                                      size: 20.r,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Icon(
                                    CupertinoIcons.person_alt,
                                    size: 20.r,
                                    color: AppColors.primary,
                                  ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.experience.userName ?? '',
                            textDirection: TextDirection.rtl,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: AppColors.grey500,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 8.r),
                        Icon(
                          CupertinoIcons.calendar,
                          color: AppColors.primary,
                          size: 22.r,
                        ),
                        Text(
                          DateActionsComponent(
                                  date: widget.experience.createDate)
                              .toJalali(),
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            !(widget.experience.isVoice ?? false)
                ? widget.experience.fileId == null
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
                            widget.experience.fileId!,
                          ),
                          width: 100.r,
                          height: 100.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Container(
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
      ),
    );
  }
}
