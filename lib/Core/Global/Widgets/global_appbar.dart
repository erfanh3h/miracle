import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Routes/app_routes.dart';

class GlobalAppbar extends StatelessWidget {
  final String title;
  final bool letBack;
  final int? fontsize;
  final Widget? flexibleSpace;
  final VoidCallback? backFunction;
  const GlobalAppbar({
    Key? key,
    required this.title,
    this.letBack = true,
    this.fontsize,
    this.flexibleSpace,
    this.backFunction,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   // Status bar color
      //   statusBarColor: Colors.transparent,
      //   // Status bar brightness (optional)
      //   statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
      // ),
      leading: letBack
          ? InkWell(
              onTap: backFunction ?? Get.back,
              child: Icon(
                CupertinoIcons.chevron_forward,
                size: 22.r,
                color: Colors.white,
              ),
            )
          : const UserAppbarIcon(),
      flexibleSpace: flexibleSpace,
      centerTitle: true,
      title: flexibleSpace == null
          ? Text(
              title,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: context.textTheme.displayMedium!.copyWith(
                fontFamily: 'Dastnevis',
                fontSize: 18,
              ),
            )
          : null,
    );
  }
}

class UserAppbarIcon extends StatelessWidget {
  const UserAppbarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var globalController = Get.find<GlobalController>();
    return Obx(
      () => InkWell(
        onTap: () => Get.toNamed(
          globalController.user == null
              ? AppRoutes.entry
              : globalController.user == null
                  ? AppRoutes.entry
                  : AppRoutes.profile,
        ),
        child: globalController.user == null
            ? Icon(
                CupertinoIcons.person_alt,
                size: 25.r,
              )
            : Container(
                width: 35.r,
                height: 35.r,
                margin: AppSpacings.s5All,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: AppColors.white,
                  //   width: .6,
                  // ),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.r),
                  child: Icon(CupertinoIcons.person_alt, size: 25.r),
                ),
              ),
      ),
    );
  }
}
