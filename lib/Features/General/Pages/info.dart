import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Data/exercises_name.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/General/Controllers/info.dart';

class InfoPage extends BaseView<InfoController> {
  InfoPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: AppSpacings.s20All,
          child: Text(
            info,
            style: Get.textTheme.headline3,
          ),
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
    return FloatingActionButton(
      onPressed: controller.addReviewButton,
      child: const Icon(
        Icons.headset_mic_rounded,
        color: AppColors.white,
      ),
    );
  }
}
