import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_view.dart';
import 'package:miracle/Controllers/delneveshteh_create_controller.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Widgets/global/global_appbar.dart';
import 'package:miracle/Widgets/global/global_input_box.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';
import 'package:miracle/Widgets/global_selection_widget.dart';

class DelneveshtehCreatePage extends BaseView<DelneveshtehCreateController> {
  const DelneveshtehCreatePage({super.key});
  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.onCreateTap,
      backgroundColor: Get.context!.theme.colorScheme.primary,
      child: controller.isPageLoading.value
          ? GlobalLoadingWidget()
          : const Icon(Icons.save, color: AppColors.lightColor),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return GlobalAppbar(
      title: 'افزودن دل نوشته',
      // actions: [
      //   Container(
      //     alignment: Alignment.center,
      //     child: InkWell(
      //       onTap: () {},
      //       child: Padding(
      //         padding: AppSpacings.s10All,
      //         child: Icon(
      //           CupertinoIcons.checkmark_alt,
      //           size: 22.r,
      //           color: AppColors.fontDark,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    ).build(context);
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: AppSpacings.s15All,
      child: Column(
        children: [
          GlobalInputBox(
            label: "عنوان",
            controller: controller.titleCtrl,
            minLines: 1,
            maxLines: 1,
          ),
          GlobalInputBox(
            label: "متن",
            controller: controller.contentCtrl,
            minLines: 3,
            maxLines: 5,
          ),
          GlobalSelectionWidget(
            selectionData: reviewCategories,
            onTap: controller.changeCategoryId,
            value: controller.categoryIdController.value,
            label: "موضوع",
          ),
        ],
      ),
    );
  }
}
