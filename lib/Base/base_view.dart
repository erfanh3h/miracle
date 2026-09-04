import 'package:flutter/material.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';

import '../Resources/app_colors.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends StatelessWidget {
  const BaseView({super.key});

  final String? tag = null;

  T get controller => Get.find<T>(tag: tag);

  AppBar? appBar(BuildContext context) {
    return null;
  }

  // GlobalKey<ScaffoldState>? setScaffoldKey({GlobalKey<ScaffoldState>? value}) {
  //   GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  //   if (value != null) {
  //     globalKey = value;
  //   }
  //   return globalKey;
  // }

  // You can Override it
  bool safeAreaState() {
    return false;
  }

  // You can Override it
  bool resizeToAvoidBottomInset() {
    return false;
  }

  // this use to determine we need will pop scope or not(in ios on will pop scope won't work)
  bool setWillPopScope() {
    return false;
  }

  bool preventPop() {
    return false;
  }

  // this use to separate type of bodies
  bool isSingleBody() {
    return true;
  }

  bool extendBodyBehindNavigationBar() {
    return false;
  }

  bool extendBodyBehindAppBar() {
    return false;
  }

  Widget body(BuildContext context);

  Widget tabletBody(BuildContext context) => body(context);

  Widget webBody(BuildContext context) => body(context);

  @override
  Widget build(BuildContext context) {
    return pageContent(context);
  }

  Widget pageScaffold(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: pageBackgroundColor(context),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        // key: setScaffoldKey(),
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: floatingActionButtonLocation(),
        extendBodyBehindAppBar: extendBodyBehindAppBar(),
        extendBody: extendBodyBehindNavigationBar(),
        body: controller.isPageLoading.value
            ? _showLoading()
            : safeAreaState()
            ? SafeArea(child: body(context))
            : body(context),

        drawer: drawer(),
        endDrawer: endDrawer(),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget pageContent(BuildContext context) {
    return setWillPopScope()
        ? BackButtonListener(
            onBackButtonPressed: () {
              return Future.value(preventPop());
            },
            child: pageScaffold(context),
          )
        : pageScaffold(context);
  }

  Color pageBackgroundColor(BuildContext context) {
    return context.theme.colorScheme.surface;
  }

  Color statusBarColor() {
    return AppColors.transparent;
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget? endDrawer() {
    return null;
  }

  Widget _showLoading() {
    return const GlobalLoadingWidget();
  }

  FloatingActionButtonLocation? floatingActionButtonLocation() {
    return FloatingActionButtonLocation.endFloat;
  }
}
