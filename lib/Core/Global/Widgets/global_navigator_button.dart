import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';

class GlobalNavigatorButton extends StatelessWidget {
  const GlobalNavigatorButton({
    Key? key,
    this.function,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? function;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: AppSpacings.s10All,
        color: AppColors.white,
        child: Row(children: [
          Icon(icon, color: AppColors.primary, size: 25.r),
          SizedBox(width: 5.r),
          Text(title, style: Get.textTheme.headline3),
        ]),
      ),
    );
  }
}
