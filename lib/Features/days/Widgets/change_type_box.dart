import 'package:flutter/material.dart';
import 'package:refreshed/get_utils/get_utils.dart';

import '../../../Core/Resources/app_colors.dart';
import '../../../Core/Resources/app_spacings.dart';

class ChangeTypeBox extends StatelessWidget {
  const ChangeTypeBox({
    super.key,
    required this.isLogin,
    required this.onChangeType,
  });

  final bool isLogin;
  final Function(bool) onChangeType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (() {
            onChangeType(true);
          }),
          child: Container(
            padding: AppSpacings.s10All,
            decoration: BoxDecoration(
              color: isLogin ? context.theme.primaryColor : AppColors.grey300,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              'ورود',
              style: context.textTheme.displaySmall!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() {
            onChangeType(false);
          }),
          child: Container(
            padding: AppSpacings.s10All,
            decoration: BoxDecoration(
              color: !isLogin ? context.theme.primaryColor : AppColors.grey300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(
              'ثبت نام',
              style: context.textTheme.displaySmall!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
