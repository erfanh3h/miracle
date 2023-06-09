import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';

import '../resources/app_colors.dart';
import 'base_controller.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  BaseView({final Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  AppBar? appBar(final BuildContext context) {
    return null;
  }

  // You can Override it
  bool safeArea() {
    return false;
  }

  // You can Override it
  bool resizeToAvoidBottomInset() {
    return false;
  }

  Future<bool> onWillPop(final BuildContext context) async {
    // Navigator.of(context).pop();
    return true;
  }

  // this use to seperate type of bodies
  bool isSingleBody() {
    return true;
  }

  Widget body(final BuildContext context);
  Widget tabletBody(final BuildContext context) => body(context);
  Widget webBody(final BuildContext context) => body(context);

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: pageContent(context),
    );
  }

  Widget annotatedRegion(final BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          //Status bar color for android
          statusBarColor: statusBarColor(),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: statusBarColor(),
          statusBarBrightness: Brightness.light),
      child: pageContent(context),
    );
  }

  Widget pageScaffold(final BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        //sets ios status bar color
        backgroundColor: pageBackgroundColor(),
        key: globalKey,
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: floatingActionButtonLocation(),
        body: Obx(
          () => controller.isPageLoading.value ? _showLoading() : body(context),
        ),
        // this couse keyboard close problem
        // body: LayoutBuilder(builder: (context, cons) {
        //   if (cons.maxWidth < 600) {
        //     return body(context);
        //   } else if (cons.maxWidth < 1200) {
        //     return tabletBody(context);
        //   } else {
        //     return webBody(context);
        //   }
        // }),
        bottomNavigationBar: bottomNavigationBar(),
        endDrawer: drawer(),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      ),
    );
  }

  Widget pageContent(final BuildContext context) {
    return safeArea()
        ? SafeArea(
            child: pageScaffold(context),
          )
        : pageScaffold(context);
  }

  Widget showErrorSnackBar(final String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container(
      color: AppColors.background,
    );
  }

  Color pageBackgroundColor() {
    return AppColors.background;
  }

  Color statusBarColor() {
    return Colors.transparent;
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

  Widget _showLoading() {
    return const GlobalLoadingWidget();
  }

  FloatingActionButtonLocation? floatingActionButtonLocation() {
    return FloatingActionButtonLocation.startFloat;
  }
}
