import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_view.dart';
import 'package:miracle/Controllers/delneveshteh_create_controller.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Widgets/global/global_appbar.dart';

class DelneveshtehCreatePage extends BaseView<DelneveshtehCreateController> {
  const DelneveshtehCreatePage({super.key});
  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.onCreateTap,
      backgroundColor: Get.overlayContext!.theme.colorScheme.primary,
      child: const Icon(Icons.save_alt_rounded, color: AppColors.lightColor),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      title: 'افزودن دل نوشته',
      // actions: [
      //   Container(
      //     alignment: Alignment.center,
      //     child: InkWell(
      //       onTap: () {},
      //       child: Padding(
      //         padding: AppSpacings.s10All,
      //         child: Icon(
      //           CupertinoIcons.checkmark_alt,
      //           size: 22.r,
      //           color: AppColors.fontDark,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    ).build(context);
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }
}
