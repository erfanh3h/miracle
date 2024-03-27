import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Data/exercises_name.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/app_routes.dart';

class DayRowNavigatorBox extends StatelessWidget {
  final int index;
  const DayRowNavigatorBox({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.days, arguments: index + 1),
        // highlightColor: Theme.of(context).primaryColor.withOpacity(.15),
        child: Container(
          padding: AppSpacings.s5All,
          decoration: const BoxDecoration(
              // border: Border.all(
              // color: Theme.of(context).primaryColor,
              // ),
              // borderRadius: BorderRadius.circular(10),
              ),
          child: Center(
            child: Text(
              '${index + 1}. ${exercisesNames[index]}',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: context.textTheme.displayMedium,
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ),
    );
  }
}
