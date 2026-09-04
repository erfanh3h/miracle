import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';
import 'package:miracle/Routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final globalController = Get.find<GlobalController>();
    Get.offAllNamed(AppRoutes.main);
    // globalController.fetchUserData().then(
    //   (value) {
    //     if (value) {
    //       Get.offAllNamed(AppRoutes.main);
    //     } else {
    //       Get.offAllNamed(AppRoutes.profile);
    //     }
    //   },
    // );

    return const Scaffold(body: GlobalLoadingWidget());
  }
}
