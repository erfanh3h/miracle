import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

import 'user_appbar_icon.dart';

class GlobalAppbar extends StatelessWidget {
  final String title;
  final bool letBack;
  final int? fontsize;
  const GlobalAppbar({
    Key? key,
    required this.title,
    this.letBack = true,
    this.fontsize,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      leading: letBack
          ? InkWell(
              onTap: Get.back,
              child: Icon(
                CupertinoIcons.chevron_back,
                size: 25.r,
              ),
            )
          : const UserAppbarIcon(),
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: Get.textTheme.subtitle1!.copyWith(
          fontFamily: 'neirizi',
          color: AppColors.white,
          fontSize: (fontsize ?? 16).r,
        ),
      ),
    );
  }
}
