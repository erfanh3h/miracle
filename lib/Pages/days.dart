import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_view.dart';
import 'package:miracle/Data/exercises_name.dart';
import 'package:miracle/Data/itemable_days.dart';
import 'package:miracle/Widgets/global/global_appbar.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Routes/app_routes.dart';
import 'package:miracle/Controllers/days.dart';
import 'package:miracle/Widgets/days/day_content_box.dart';
import 'package:miracle/Widgets/days/day_item_row_box.dart';
import 'package:miracle/Widgets/global/global_submit_button.dart';

class DaysPage extends BaseView<DaysController> {
  DaysPage({super.key});

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
              child: GlobalSubmitButton(
                tapFunction: () {
                  Get.toNamed(AppRoutes.days, arguments: 1);
                },
                title: 'ابتدا تمرین روز اول رو تکرار کن',
                margin: AppSpacings.s10Bottom,
                padding: AppSpacings.s10Horizental,
              ),
            ),
          ),
          DayContentBox(content: controller.exerciseContent),
          Visibility(
            visible: itemableDays.contains(controller.dayNumber),
            child: const Center(
              child: Padding(
                padding: AppSpacings.s20Vertical,
                child: SizedBox(
                  width: 125,
                  child: Divider(color: AppColors.primary, thickness: 2.0),
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
                      itemBuilder: (ctx, ind) =>
                          ind < controller.data.value.length
                          ? DayItemRowBox(
                              index: ind + 1,
                              data: controller.data.value[ind],
                              deleteFunction: () => controller.deleteData(ind),
                              onDeleteReturnFunction: controller.fetchData,
                            )
                          : Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.addDay,
                                    arguments: controller.dayNumber,
                                  )!.then((value) {
                                    controller.fetchData();
                                    // if (value ?? false) {
                                    //   controller.fetchData();
                                    // }
                                  });
                                },
                                child: Icon(
                                  Icons.add_rounded,
                                  color:
                                      context.theme.colorScheme.inverseSurface,
                                  size: 40,
                                ),
                              ),
                            ),
                      itemCount: controller.data.value.length + 1,
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
      // actions: [
      //   Container(
      //     alignment: Alignment.center,
      //     child: InkWell(
      //       onTap: () {},
      //       child: Padding(
      //         padding: AppSpacings.s10All,
      //         child: Icon(
      //           CupertinoIcons.checkmark_alt,
      //           size: 22.r,
      //           color: AppColors.fontDark,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    ).build(context);
  }

  @override
  Widget? floatingActionButton() {
    return controller.currentDay <= controller.dayNumber
        ? FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'تکمیل روز',
                middleText: 'تمرین امروز تکمیل شد؟',
                middleTextStyle: Get.context!.textTheme.displayMedium,
                titleStyle: Get.context!.textTheme.displayLarge,
                actions: [
                  TextButton(
                    onPressed: controller.finishDay,
                    child: Text(
                      'آره',
                      style: Get.context!.textTheme.displaySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: Get.closeDialog,
                    child: Text(
                      'هنوز نه',
                      style: Get.context!.textTheme.displaySmall,
                    ),
                  ),
                ],
              );
            },
            child: const Icon(
              CupertinoIcons.checkmark_alt,
              color: AppColors.white,
            ),
          )
        : null;
  }
}
