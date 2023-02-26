import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';

class GlobalSubmitButton extends StatelessWidget {
  const GlobalSubmitButton({
    Key? key,
    required this.tapFunction,
    required this.title,
    this.padding,
    this.margin,
    this.color,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback tapFunction;
  final String title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          if (!isLoading) {
            tapFunction();
          }
        },
        child: Container(
          padding: AppSpacings.s10All,
          decoration: BoxDecoration(
            color: color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: isLoading
                ? const GlobalLoadingWidget(
                    color: AppColors.white,
                  )
                : Text(
                    title,
                    style: Get.textTheme.labelLarge,
                  ),
          ),
        ),
      ),
    );
  }
}
