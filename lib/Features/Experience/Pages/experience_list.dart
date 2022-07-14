import 'package:flutter/material.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Features/Experience/Controllers/experience_list_controller.dart';

class ExperienceListPage extends BaseView<ExperienceListController> {
  ExperienceListPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: const [],
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(
      title: 'تجربیات',
      letBack: false,
    ).build(context);
  }
}
