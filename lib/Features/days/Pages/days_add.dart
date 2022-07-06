import 'package:flutter/material.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Features/days/Controllers/days_add.dart';
import 'package:miracle/Features/days/Widgets/add_widgets/add_title.dart';
import 'package:miracle/Features/days/Widgets/add_widgets/add_title_content.dart';
import 'package:miracle/Features/days/Widgets/add_widgets/add_title_content_image.dart';
import 'package:miracle/Features/days/Widgets/add_widgets/add_title_multi_content.dart';

class DaysAddPage extends BaseView<DaysAddController> {
  DaysAddPage({Key? key}) : super(key: key);

  @override
  bool resizeToAvoidBottomInset() {
    return true;
  }

  @override
  Widget body(BuildContext context) {
    Widget body;
    switch (controller.dayNumber) {
      case 1:
        body = AddTitleContentBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 3:
        body = AddTitleContentImageBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 5:
        body = AddTitleBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 7:
        body = AddTitleMultiContentBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 12:
        body = AddTitleContentBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 13:
        body = AddTitleMultiContentBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
          maxLength: 3,
        );
        break;
      case 15:
        body = AddTitleMultiContentBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 18:
        body = AddTitleBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 20:
        body = AddTitleBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 21:
        body = AddTitleBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 25:
        body = AddTitleBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 26:
        body = AddTitleMultiContentBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      case 27:
        body = AddTitleBox(
          ontapFunction: controller.createData,
          dayNumber: controller.dayNumber,
        );
        break;
      default:
        body = Container();
    }
    return body;
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(title: 'افزودن اطلاعات').build(context);
  }
}
