import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/General/Controllers/home.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/General/Widgets/day_row_navigator_box.dart';

import 'package:miracle/Core/Base/base_view.dart';

class HomePage extends BaseView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: GridView.builder(
              padding: AppSpacings.s10All,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 175,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (ctx, ind) => DayRowNavigatorBox(index: ind),
              itemCount: 28,
            ),
          ),
        );
      },
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      title: '',
      letBack: false,
      flexibleSpace: Container(
        padding: AppSpacings.s20Top10Right10Left,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              child: const UserAppbarIcon(),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'معجزه',
                // textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Dastnevis',
                  color: AppColors.white,
                  fontSize: 21,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.info);
                },
                child: Padding(
                  padding: AppSpacings.s10All,
                  child: Icon(
                    CupertinoIcons.info,
                    size: 22.r,
                    // color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).build(context);
  }
}
