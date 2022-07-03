import 'package:get/get.dart';
import 'package:miracle/Core/Global/Pages/main_screen.dart';
import 'package:miracle/Core/Global/Pages/splash.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Auth/Pages/entry.dart';
import 'package:miracle/Features/Auth/Pages/register.dart';
import 'package:miracle/Features/Feature/General/Pages/home.dart';
import 'package:miracle/Features/days/Core/days_page_binding.dart';
import 'package:miracle/Features/days/Pages/days.dart';
import 'package:miracle/Features/days/Pages/days_add.dart';
import 'package:miracle/Features/days/Pages/days_show.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.main,
      page: MainScreen.new,
    ),
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
    GetPage(
      name: AppRoutes.entry,
      page: EntryPage.new,
    ),
    GetPage(
      name: AppRoutes.register,
      page: RegisterPage.new,
    ),
  ];
}
