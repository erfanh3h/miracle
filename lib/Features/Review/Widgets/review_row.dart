// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Components/date_actions.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/Review/Models/review.dart';

class ReviewRow extends StatelessWidget {
  const ReviewRow({
    Key? key,
    required this.review,
  }) : super(key: key);

  final ReviewModel review;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s10All,
      margin: AppSpacings.s10Bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.pen,
                color: AppColors.primary,
                size: 14.r,
              ),
              Flexible(
                child: Text(
                  review.userName ?? '',
                  textDirection: TextDirection.rtl,
                  style: Get.textTheme.caption!.copyWith(
                    color: AppColors.grey500,
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 8.r),
              Icon(
                CupertinoIcons.calendar,
                color: AppColors.primary,
                size: 14.r,
              ),
              Text(
                DateActionsComponent(date: review.createDate).toJalali(),
                style: Get.textTheme.caption!.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
          Text(
            review.review ?? '',
            style: Get.textTheme.caption,
          ),
        ],
      ),
    );
  }
}
