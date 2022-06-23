import 'package:flutter/material.dart';
import 'package:miracle/Core/Base/base_view.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Core/Widgets/global_appbar.dart';
import 'package:miracle/Features/General/Controllers/home.dart';
import 'package:miracle/Features/General/Widgets/day_row_navigator_box.dart';

class HomePage extends BaseView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: GridView.builder(
              padding: AppSpacings.s10All,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 175,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (ctx, ind) => DayRowNavigatorBox(index: ind),
              itemCount: 28,
            ),
          ),
        );
      },
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return const GlobalAppbar(
      title: 'معجزه',
      letBack: false,
      fontsize: 26,
    ).build(context);
  }
}
