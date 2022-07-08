import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();

    globalController.fetchUserData(context).then(
      (value) {
        if (value) {
          Get.offAllNamed(AppRoutes.main);
        } else {
          Get.offAllNamed(AppRoutes.profile);
        }
      },
    );

    return const Scaffold(body: GlobalLoadingWidget());
  }
}
