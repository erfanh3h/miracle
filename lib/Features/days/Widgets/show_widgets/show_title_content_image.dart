import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class ShowTitleContentImageBox extends StatelessWidget {
  const ShowTitleContentImageBox({
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
          Container(
            padding: AppSpacings.s10All,
            margin: AppSpacings.s10Bottom,
            decoration: const BoxDecoration(),
            child: Image.memory(
              data.image!,
              width: Get.width / 2,
              height: Get.width / 2,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: AppSpacings.s10All,
            child: Text(
              data.title ?? '',
              style: Get.textTheme.headline1,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: AppSpacings.s10Horizental,
            child: Text(
              data.content ?? '',
              style: Get.textTheme.headline2,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}