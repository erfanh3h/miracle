import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Data/exercises_name.dart';
import 'package:miracle/Core/Data/itemable_days.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/days/Controllers/days.dart';
import 'package:miracle/Features/days/Widgets/day_content_box.dart';
import 'package:miracle/Features/days/Widgets/day_item_row_box.dart';

class DaysPage extends BaseView<DaysController> {
  DaysPage({Key? key}) : super(key: key);

  final controllerTag = Get.arguments.toString();
  @override
  String? get tag => controllerTag;

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Visibility(
              visible: controller.dayNumber != 1,
              child: Padding(
                padding: AppSpacings.s20All,
                child: Text(
                  'ابتدا تمرین روز اول رو تکرار کن',
                  style: context.textTheme.bodyLarge,
                ),
              )
              //TODO : add this whenever find a way for duplicate pag issue

              // GlobalSubmitButton(
              //   tapFunction: () {
              //     // Get.toNamed(AppRoutes.days, arguments: 1);
              //   },
              //   title: 'ابتدا تمرین روز اول رو تکرار کن',
              //   margin: AppSpacings.s10Bottom,
              //   padding: AppSpacings.s10Horizental,
              // ),
              ),
          DayContentBox(
            content: controller.exerciseContent,
          ),
          Visibility(
            visible: itemableDays.contains(controller.dayNumber),
            child: const Center(
              child: Padding(
                padding: AppSpacings.s20Vertical,
                child: SizedBox(
                  width: 125,
                  child: Divider(
                    color: AppColors.primary,
                    thickness: 2.0,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: itemableDays.contains(controller.dayNumber),
            child: Obx(
              () => Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: Padding(
                    padding: AppSpacings.s50Bottom,
                    child: GridView.builder(
                      padding: AppSpacings.s10All,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100.r,
                        childAspectRatio: 4 / 4,
                        crossAxisSpacing: 10.r,
                        mainAxisSpacing: 10.r,
                      ),
                      itemBuilder: (ctx, ind) => DayItemRowBox(
                        index: ind + 1,
                        data: controller.data.value[ind],
                        deleteFunction: () => controller.deleteData(ind),
                        onDeleteReturnFunction: controller.fetchData,
                      ),
                      itemCount: controller.data.value.length,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      title:
          '${controller.dayNumber}. ${exercisesNames[controller.dayNumber - 1]}',
    ).build(context);
  }

  @override
  Widget? floatingActionButton() {
    return itemableDays.contains(controller.dayNumber)
        ? FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addDay, arguments: controller.dayNumber)!
                  .then((value) {
                // if (value ?? false) {
                //   controller.fetchData();
                // }
              });
            },
            child: const Icon(
              CupertinoIcons.add,
              color: AppColors.white,
            ),
          )
        : null;
  }
}
