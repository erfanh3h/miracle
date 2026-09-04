import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_view.dart';
import 'package:miracle/Data/exercises_name.dart';
import 'package:miracle/Widgets/global/global_appbar.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Controllers/info.dart';

class InfoPage extends BaseView<InfoController> {
  const InfoPage({super.key});

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: AppSpacings.s20All,
          child: Text(info, style: Get.context!.textTheme.bodyLarge),
        ),
      ],
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(title: 'درباره').build(context);
  }

  @override
  Widget? floatingActionButton() {
    return controller.letSendReview.value
        ? FloatingActionButton(
            onPressed: controller.addReviewButton,
            child: const Icon(
              Icons.headset_mic_rounded,
              color: AppColors.white,
            ),
          )
        : null;
  }
}
