import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/delneveshteh_controller.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Widgets/delneveshte_row_box.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';

class DelneveshtePage extends StatelessWidget {
  DelneveshtePage({super.key});

  final controller = Get.find<DelneveshtehController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.readData(mustRefresh: true);
      },
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            height: 35.h,
            margin: AppSpacings.s10Horizental,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => ReviewFilterButton(
                id: reviewCategories[index],
                isTapped:
                    controller.selectedCategory.value ==
                    reviewCategories[index],
                onTap: controller.onChangeCategory,
              ),
              separatorBuilder: (ctx, index) => SizedBox(width: 5.w),
              itemCount: reviewCategories.length,
            ),
          ),
          Expanded(
            child: controller.isPageLoading.value
                ? Center(child: GlobalLoadingWidget())
                : GridView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.w,
                      horizontal: 15.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 7 / 9,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.w,
                    ),
                    itemBuilder: (ctx, ind) => FadeIn(
                      delay: Duration(milliseconds: 50 * ind),
                      child: DelneveshtehRowBox(data: controller.data[ind]),
                    ),
                    itemCount: controller.data.length,
                  ),
          ),
        ],
      ),
    );
  }
}

class ReviewFilterButton extends StatelessWidget {
  const new({
    super.key,
    required this.id,
    required this.isTapped,
    required this.onTap,
  });

  final String id;
  final bool isTapped;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(id);
      },
      child: Card(
        color: isTapped ? context.theme.colorScheme.secondary : null,
        child: Padding(
          padding: AppSpacings.s10All,
          child: Center(
            child: Text(
              id.isEmpty ? "همه" : id,
              style: context.theme.textTheme.headlineMedium!.copyWith(
                color: isTapped ? AppColors.lightColor : AppColors.darkColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
