import 'package:miracle/Core/days_binding.dart';
import 'package:miracle/Core/global_binding.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Core/review_binding.dart';
import 'package:miracle/Routes/app_routes.dart';
import 'package:miracle/Pages/home.dart';
import 'package:miracle/Pages/info.dart';
import 'package:miracle/Core/days_page_binding.dart';
import 'package:miracle/Pages/days.dart';
import 'package:miracle/Pages/days_add.dart';
import 'package:miracle/Pages/days_show.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.main,
      page: HomePage.new,
      bindings: [GlobalBinding()],
    ),
    // GetPage(
    //   name: AppRoutes.splash,
    //   page: SplashPage.new,
    //   // binding: LandingBinding(),
    //   // children: [
    //   // GetPage(
    //   //   name: AppRoutes.days,
    //   //   page: DaysPage.new,
    //   //   binding: DaysPageBinding(),
    //   // ),
    //   // ],
    // ),
    GetPage(name: AppRoutes.home, page: HomePage.new),
    GetPage(
      name: AppRoutes.days,
      page: DaysPage.new,
      bindings: [DaysPageBinding()],
      preventDuplicates: false,
    ),
    GetPage(
      name: AppRoutes.addDay,
      page: DaysAddPage.new,
      bindings: [DaysAddBinding()],
    ),
    GetPage(
      name: AppRoutes.daysShow,
      page: DaysShowPage.new,
      bindings: [DaysShowBinding()],
    ),
    GetPage(
      name: AppRoutes.info,
      page: InfoPage.new,
      bindings: [ReviewBinding()],
    ),
  ];
}
