import 'package:flutter/material.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Features/Experience/Controllers/add_experience_controller.dart';

class AddExperiencePage extends BaseView<AddExperienceController> {
  AddExperiencePage({Key? key}) : super(key: key);

  @override
  bool resizeToAvoidBottomInset() {
    return true;
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(title: 'افزودن تجربه').build(context);
  }
}
