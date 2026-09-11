import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Routes/app_routes.dart';
import 'package:miracle/Widgets/appwrite_image.dart';

class DelneveshtehRowBox extends StatelessWidget {
  const new({super.key, required this.data});

  final DelneveshtehModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.readDelneveshteh, arguments: data),
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisSize: .max,
          children: [
            SizedBox(height: 5.h),
            Card(
              child: Padding(
                padding: AppSpacings.s5All,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: context.theme.colorScheme.surface,
                      radius: 17,
                      child: data.authorImage == null
                          ? Icon(
                              Icons.person,
                              size: 20,
                              color: context.theme.colorScheme.inverseSurface,
                            )
                          : AppwriteImage(fileId: data.authorImage!),
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          data.authorName,
                          style: context.theme.textTheme.headlineMedium,
                        ),
                        Text(
                          data.categoryId,
                          style: context.theme.textTheme.headlineSmall!
                              .copyWith(fontFamily: FontFamilies.dastnevis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              data.title,
              style: context.theme.textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: AppSpacings.s10Horizental,
              child: Text(
                data.content,
                style: context.theme.textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: context.theme.colorScheme.inverseSurface,
                ),
                Text(
                  data.likeCount.toString(),
                  style: TextStyle(
                    color: context.theme.colorScheme.inverseSurface,
                    fontFamily: FontFamilies.dastnevis,
                  ),
                ),
                Spacer(flex: 5),
                Icon(
                  Icons.chat_rounded,
                  color: context.theme.colorScheme.inverseSurface,
                ),
                Text(
                  data.reviewCount.toString(),
                  style: TextStyle(
                    color: context.theme.colorScheme.inverseSurface,
                    fontFamily: FontFamilies.dastnevis,
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
