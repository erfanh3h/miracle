import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Resources/app_colors.dart';

class GlobalAppbar extends StatelessWidget {
  final String title;
  final bool letBack;
  final int? fontsize;
  final VoidCallback? backFunction;
  final TextStyle? textStyle;
  final Widget? leading;
  final List<Widget>? actions;
  const GlobalAppbar({
    super.key,
    required this.title,
    this.letBack = true,
    this.fontsize,
    this.backFunction,
    this.textStyle,
    this.leading,
    this.actions,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: letBack
          ? InkWell(
              onTap: backFunction ?? Get.back,
              child: Icon(
                CupertinoIcons.chevron_forward,
                size: 22.r,
                color: AppColors.fontDark,
              ),
            )
          : leading,
      actions: actions ?? [],
      actionsPadding: EdgeInsets.only(left: 5),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: AppColors.fontDark, fontFamily: "Dastnevis"),
      ),
    );
  }
}
