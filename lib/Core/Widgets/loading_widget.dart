import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.color,
    Key? key,
  }) : super(key: key);

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
      ),
    );
  }
}
