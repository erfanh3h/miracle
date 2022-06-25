import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Features/Auth/Controllers/register.dart';

class RegisterPage extends BaseView<RegisterController> {
  RegisterPage({Key? key}) : super(key: key);

  final controllerTag = Get.arguments.toString();
  @override
  String? get tag => controllerTag;

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // @override
  // AppBar? appBar(BuildContext context) {
  //   return GlobalAppbar(
  //     title:
  //         '${controller.dayNumber}. ${exercisesNames[controller.dayNumber - 1]}',
  //   ).build(context);
  // }

}
