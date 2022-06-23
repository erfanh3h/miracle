import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Widgets/global_appbar.dart';
import 'package:miracle/Features/days/Controllers/days_show.dart';
import 'package:miracle/Features/days/Widgets/show_widgets/show_title_content.dart';
import 'package:miracle/Features/days/Widgets/show_widgets/show_title_content_image.dart';
import 'package:miracle/Features/days/Widgets/show_widgets/show_title_multi_content.dart';

class DaysShowPage extends BaseView<DaysShowController> {
  DaysShowPage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    Widget body;
    switch (controller.data.dayNumber) {
      case 1:
        body = ShowTitleContentBox(data: controller.data);
        break;
      case 3:
        body = ShowTitleContentImageBox(data: controller.data);
        break;
      case 7:
        body = ShowTitleMultiContentBox(data: controller.data);
        break;
      case 12:
        body = ShowTitleContentBox(data: controller.data);
        break;
      case 13:
        body = ShowTitleMultiContentBox(data: controller.data);
        break;
      case 15:
        body = ShowTitleMultiContentBox(data: controller.data);
        break;
      case 26:
        body = ShowTitleMultiContentBox(data: controller.data);
        break;
      default:
        body = Container();
    }
    return body;
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(title: 'نمایش اطلاعات').build(context);
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.defaultDialog(
          title: 'حذف',
          middleText: 'آیا برای حذف اطمینان دارید؟',
          actions: [
            TextButton(
              onPressed: controller.deleteFromStorage,
              child: const Text('بله'),
            ),
            TextButton(
              onPressed: Get.back,
              child: const Text('خیر'),
            ),
          ],
        );
      },
      child: const Icon(CupertinoIcons.delete, color: AppColors.white),
    );
  }
}
