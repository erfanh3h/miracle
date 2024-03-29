import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Widgets/global_appbar.dart';
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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          padding: AppSpacings.s20Top10Right10Left,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                child: const UserAppbarIcon(),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'معجزه',
                  textDirection: TextDirection.rtl,
                  style: context.textTheme.titleMedium,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.info);
                  },
                  child: Padding(
                    padding: AppSpacings.s5All,
                    child: Icon(
                      CupertinoIcons.info,
                      size: 22.r,
                      // color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: null,
      ),
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
