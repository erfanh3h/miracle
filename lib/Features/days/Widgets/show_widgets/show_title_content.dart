import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class ShowTitleContentBox extends StatelessWidget {
  const ShowTitleContentBox({
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
        // color: AppColors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView(
        children: [
          Padding(
            padding: AppSpacings.s10All,
            child: Text(
              data.title ?? '',
              style: context.textTheme.bodyLarge,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: AppSpacings.s10Horizental,
            child: Text(
              data.content ?? '',
              style: context.textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
