import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class ShowTitleMultiContentBox extends StatelessWidget {
  const ShowTitleMultiContentBox({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DaysModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: Get.height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView(
        children: [
          Padding(
            padding: AppSpacings.s10All,
            child: Text(
              data.title ?? '',
              style: Get.textTheme.headline1,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) => Padding(
              padding: AppSpacings.s10Horizental,
              child: Text(
                data.multiContents![index],
                style: Get.textTheme.headline2,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
              ),
            ),
            separatorBuilder: (ctx, index) => const Padding(
              padding: AppSpacings.s20Vertical,
              child: SizedBox(
                width: 125,
                child: Divider(
                  color: AppColors.primary,
                  thickness: .25,
                ),
              ),
            ),
            itemCount: data.multiContents!.length,
          )
        ],
      ),
    );
  }
}
