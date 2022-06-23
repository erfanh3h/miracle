import 'package:get/get.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Core/splash.dart';
import 'package:miracle/Features/General/Pages/home.dart';
import 'package:miracle/Features/days/Core/days_page_binding.dart';
import 'package:miracle/Features/days/Pages/days.dart';
import 'package:miracle/Features/days/Pages/days_add.dart';
import 'package:miracle/Features/days/Pages/days_show.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashPage.new,
      // binding: LandingBinding(),
      // children: [
      // GetPage(
      //   name: AppRoutes.days,
      //   page: DaysPage.new,
      //   binding: DaysPageBinding(),
      // ),
      // ],
    ),
    GetPage(
      name: AppRoutes.home,
      page: HomePage.new,
    ),
    GetPage(
      name: AppRoutes.days,
      page: DaysPage.new,
      binding: DaysPageBinding(),
    ),
    GetPage(
      name: AppRoutes.daysAdd,
      page: DaysAddPage.new,
    ),
    GetPage(
      name: AppRoutes.daysShow,
      page: DaysShowPage.new,
    ),
  ];
}
