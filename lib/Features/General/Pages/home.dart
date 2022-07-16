import 'package:flutter/material.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/General/Widgets/day_row_navigator_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppbar(
        title: 'معجزه',
        letBack: false,
        fontsize: 26,
      ).build(context),
      body: LayoutBuilder(
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
      ),
    );
  }
}

// class HomePage extends BaseView<HomeController> {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   Widget body(BuildContext context) {
//     return LayoutBuilder(
//       builder: (ctx, cons) {
//         return Directionality(
//           textDirection: TextDirection.rtl,
//           child: Center(
//             child: GridView.builder(
//               padding: AppSpacings.s10All,
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 175,
//                 childAspectRatio: 4 / 4,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//               ),
//               itemBuilder: (ctx, ind) => DayRowNavigatorBox(index: ind),
//               itemCount: 28,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   AppBar? appBar(BuildContext context) {
//     return const GlobalAppbar(
//       title: 'معجزه',
//       letBack: false,
//       fontsize: 26,
//     ).build(context);
//   }
// }
