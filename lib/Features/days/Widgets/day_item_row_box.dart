import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Data/itemable_days.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/days/Models/days.dart';

class DayItemRowBox extends StatelessWidget {
  final int index;
  final DaysModel data;
  final VoidCallback deleteFunction;
  final VoidCallback onDeleteReturnFunction;

  const DayItemRowBox({
    Key? key,
    required this.index,
    required this.data,
    required this.deleteFunction,
    required this.onDeleteReturnFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showableDays.contains(data.dayNumber)) {
          Get.toNamed(AppRoutes.daysShow, arguments: [data, index])!
              .then((value) {
            onDeleteReturnFunction();
            // if (value ?? false) {
            //   onDeleteReturnFunction();
            // }
          });
        }
      },
      onDoubleTap: () {
        Get.defaultDialog(
          title: 'حذف',
          middleText: 'آیا برای حذف اطمینان دارید؟',
          middleTextStyle: context.textTheme.displayMedium,
          titleStyle: context.textTheme.displayLarge,
          actions: [
            TextButton(
              onPressed: () async {
                deleteFunction();
              },
              child: Text(
                'بله',
                style: context.textTheme.displaySmall,
              ),
            ),
            TextButton(
              onPressed: Get.closeAllDialogs,
              child: Text(
                'خیر',
                style: context.textTheme.displaySmall,
              ),
            ),
          ],
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: AppSpacings.s5All,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$index. ${data.title}',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: context.textTheme.displaySmall,
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
