import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/delneveshteh_controller.dart';
import 'package:miracle/Widgets/delneveshte_row_box.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';

class DelneveshtePage extends StatelessWidget {
  DelneveshtePage({super.key});

  final controller = Get.find<DelneveshtehController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.readData();
      },
      child: controller.isPageLoading.value
          ? Center(child: GlobalLoadingWidget())
          : GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 7 / 9,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 5.w,
              ),
              itemBuilder: (ctx, ind) =>
                  DelneveshtehRowBox(data: controller.data[ind]),
              itemCount: controller.data.length,
            ),
    );
  }
}
