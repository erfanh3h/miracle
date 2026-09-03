import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class ShowTitleContentBox extends StatelessWidget {
  const ShowTitleContentBox({super.key, required this.data});

  final DaysModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
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
