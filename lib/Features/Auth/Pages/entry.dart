import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Features/Auth/Controllers/entry.dart';

class EntryPage extends BaseView<EntryController> {
  EntryPage({Key? key}) : super(key: key);

  final controllerTag = Get.arguments.toString();
  @override
  String? get tag => controllerTag;

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [],
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
