import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/delneveshteh_controller.dart';

class DelneveshtePage extends StatelessWidget {
  DelneveshtePage({super.key});

  final controller = Get.find<DelneveshtehController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Container(),
      itemCount: controller.data.length,
    );
  }
}
