import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_spacings.dart';

class GlobalSubmitButton extends StatelessWidget {
  const GlobalSubmitButton({
    super.key,
    required this.tapFunction,
    required this.title,
    this.padding,
    this.margin,
    this.color,
    this.isLoading = false,
  });

  final VoidCallback tapFunction;
  final String title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      // margin: margin ?? EdgeInsets.zero,
      // padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          if (!isLoading) {
            tapFunction();
          }
        },
        child: Padding(
          padding: AppSpacings.s15All,
          child: Center(
            child: isLoading
                ? const GlobalLoadingWidget(color: AppColors.white)
                : Text(title, style: context.textTheme.displayMedium),
          ),
        ),
      ),
    );
  }
}
