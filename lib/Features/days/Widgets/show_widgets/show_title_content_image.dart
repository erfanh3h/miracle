import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
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
