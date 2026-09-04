import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Data/exercises_name.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Routes/app_routes.dart';

class DayRowNavigatorBox extends StatelessWidget {
  final int index;
  const DayRowNavigatorBox({super.key, required this.index});

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
          child: Stack(
            children: [
              Center(
                child: Text(
                  exercisesNames[index],
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: context.textTheme.displayMedium!.copyWith(
                    fontFamily: 'vazir',
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                ),
              ),
              Positioned(
                bottom: 5,
                left: 5,
                child: Text(
                  '${index + 1}',
                  style: context.textTheme.displayMedium!.copyWith(
                    fontFamily: 'dastnevis',
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
