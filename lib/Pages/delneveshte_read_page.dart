import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_view.dart';
import 'package:miracle/Controllers/delneveshteh_read_controller.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Widgets/global/global_appbar.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';

class DelneveshteReadPage extends BaseView<DelneveshtehReadController> {
  const DelneveshteReadPage({super.key});
  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.addReviewButton,
      backgroundColor: Get.context!.theme.colorScheme.primary,
      child: const Icon(Icons.add_comment_rounded, color: AppColors.lightColor),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      title: 'دل نوشته',
      actions: [
        Container(
          alignment: Alignment.center,
          child: controller.isLikeLoading.value
              ? GlobalLoadingWidget(color: AppColors.fontDark, size: 22)
              : InkWell(
                  onTap: controller.changeLikeStatus,
                  child: Padding(
                    padding: AppSpacings.s10All,
                    child: Icon(
                      controller.isLiked.value
                          ? CupertinoIcons.heart_solid
                          : CupertinoIcons.heart,
                      size: 22.r,
                      color: AppColors.fontDark,
                    ),
                  ),
                ),
        ),
      ],
    ).build(context);
  }

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [
        Text(controller.data.title),
        Text(controller.data.content),
        SizedBox(height: 300),
        Text("نظرات"),

        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) =>
              Card(child: Text(controller.reviews[index].content)),
          separatorBuilder: (ctx, index) => SizedBox(height: 20),
          itemCount: controller.reviews.length,
        ),
      ],
    );
  }
}
