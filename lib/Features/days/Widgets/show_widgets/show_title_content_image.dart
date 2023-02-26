import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/server_routes.dart';
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
          data.imageId != null
              ? Container(
                  padding: AppSpacings.s10All,
                  margin: AppSpacings.s10Bottom,
                  decoration: const BoxDecoration(),
                  child: Image.network(
                    ServerRoutes.getFile(data.imageId!),
                    width: Get.width / 2,
                    height: Get.width / 2,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(
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
              style: Get.textTheme.displayLarge,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: AppSpacings.s10Horizental,
            child: Text(
              data.content ?? '',
              style: Get.textTheme.displayMedium,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
