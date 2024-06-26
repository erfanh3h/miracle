import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Widgets/global_bottom_navigation_bar.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Features/Experience/Pages/experience_list.dart';
import 'package:miracle/Features/General/Pages/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

  bool isInit = true;
  // bool isLoggedIn = false;
  // int _selectedIndex = 0;
  // PageController pgCtrl = PageController();
  final globalController = Get.find<GlobalController>();

  @override
  void didChangeDependencies() async {
    if (isInit) {
      // AdiveryPlugin.initialize('44cd3183-7c05-47c7-a5d3-518c9d7f4a2a');
      // AdiveryPlugin.setLoggingEnabled(true);
      // var result = await globalController.fetchUserData(context);
      // if (result) {
      //   Get.offNamed(
      //     AppRoutes.home,
      //   );
      // } else {
      //   Get.offNamed(
      //     AppRoutes.profile,
      //   );
      // }
      // isLoggedIn = await provider.initialApp(context);
      // await Provider.of<QueueProvider>(context, listen: false).tryResumeGame();
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  // DateTime? currentBackPressTime;

  // Future<bool> onWillPop() async {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Fluttertoast.showToast(msg: 'Press back again . . .');
  //     return Future.value(false);
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return isInit
        ? const Center(
            child: GlobalLoadingWidget(),
          )
        : Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: const GlobalBottomNavigationBar(),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) async {
                if (index > 4) {
                  return;
                }
                globalController.changePage(index);
              },
              controller: globalController.pgCtrl,
              children: const [
                HomePage(),
                ExperienceListPage(),
              ],
            ),
          );
  }
}
