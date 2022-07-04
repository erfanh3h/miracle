import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Core/Widgets/loading_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();

    globalController.tryAutoLogin(context).then(
          (value) => Get.offNamed(
            AppRoutes.home,
          ),
        );

    return const Scaffold(body: LoadingWidget());
  }
}
