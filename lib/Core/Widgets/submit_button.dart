import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.tapFunction,
    required this.title,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  final VoidCallback tapFunction;
  final String title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: tapFunction,
        child: Container(
          padding: AppSpacings.s10All,
          decoration: BoxDecoration(
            color: color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              title,
              style: Get.textTheme.button,
            ),
          ),
        ),
      ),
    );
  }
}
