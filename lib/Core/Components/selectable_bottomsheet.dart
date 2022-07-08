import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';

class SelectableBottomsheet {
  final List<String> rawLabels;
  final List<IconData> rawIcons;
  final List<VoidCallback> rawFunctions;
  final int itemsCount;
  final TextDirection textDirection;
  final double height;

  SelectableBottomsheet({
    required this.rawLabels,
    required this.rawIcons,
    required this.rawFunctions,
    required this.itemsCount,
    this.textDirection = TextDirection.rtl,
    this.height = 100,
  });

  void show() {
    List<Widget> labels = [];
    for (var index = 0; index < rawLabels.length; index++) {
      labels.add(
        InkWell(
          onTap: rawFunctions[index],
          child: Container(
            padding: AppSpacings.s20All,
            child: Row(
              children: [
                Icon(
                  rawIcons[index],
                  color: AppColors.primary,
                  size: 20.r,
                ),
                Text(
                  rawLabels[index],
                  textDirection: textDirection,
                  style: Get.textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      );
    }
    Get.bottomSheet(
      SizedBox(
        height: height.r,
        child: ListView(
          children: labels,
        ),
      ),
      backgroundColor: AppColors.white,
      // isScrollControlled: true,
    );
  }
}
