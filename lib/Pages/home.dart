import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Controllers/global_controller.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Routes/app_routes.dart';
import 'package:miracle/Widgets/global/global_bottom_navigation_bar.dart';
import 'package:miracle/Controllers/home_controller.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Widgets/day_row_navigator_box.dart';

import 'package:miracle/Base/base_view.dart';

class HomePage extends BaseView<HomeController> {
  const HomePage({super.key});

  @override
  bool safeAreaState() {
    return true;
  }

  @override
  bool extendBodyBehindNavigationBar() {
    return true;
  }

  @override
  Widget? bottomNavigationBar() {
    return GlobalBottomNavigationBar();
  }

  @override
  Widget body(BuildContext context) {
    return controller.activeTab.value == 1
        ? LayoutBuilder(
            builder: (ctx, cons) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: GridView.builder(
                    padding: AppSpacings.s10All,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
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
          )
        : controller.activeTab.value == 0
        ? Center(
            child: Text("ماجرا", style: TextStyle(color: Colors.black)),
          )
        : Container();
  }

  @override
  AppBar? appBar(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    return AppBar(
      leading: Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: globalController.swapTheme,
          child: Padding(
            padding: AppSpacings.s10All,
            child: Icon(
              globalController.currentTheme.isDark
                  ? Icons.nightlight_round_sharp
                  : Icons.sunny,
              size: 22.r,
              color: AppColors.fontDark,
            ),
          ),
        ),
      ),
      title: Text(
        "معجزه",
        style: TextStyle(color: AppColors.fontDark, fontFamily: "Dastnevis"),
      ),
      centerTitle: true,
      actionsPadding: EdgeInsets.only(left: 5),
      actions: [
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
                color: AppColors.fontDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
