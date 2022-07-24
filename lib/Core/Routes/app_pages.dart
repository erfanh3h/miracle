import 'package:get/get.dart';
import 'package:miracle/Core/Global/Pages/main_screen.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Auth/Pages/entry.dart';
import 'package:miracle/Features/Experience/Pages/add_experience.dart';
import 'package:miracle/Features/Experience/Pages/experience_details.dart';
import 'package:miracle/Features/Experience/Pages/liked_experience_list.dart';
import 'package:miracle/Features/Experience/Pages/user_experience_list.dart';
import 'package:miracle/Features/General/Pages/home.dart';
import 'package:miracle/Features/User/Pages/profile.dart';
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
      name: AppRoutes.addDay,
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
      name: AppRoutes.profile,
      page: ProfilePage.new,
    ),
    GetPage(
      name: AppRoutes.addExperience,
      page: AddExperiencePage.new,
    ),
    GetPage(
      name: AppRoutes.experienceDetails,
      page: ExperienceDetailsPage.new,
    ),
    GetPage(
      name: AppRoutes.likedExperienceList,
      page: LikedExperienceListPage.new,
    ),
    GetPage(
      name: AppRoutes.userExperienceList,
      page: UserExperienceListPage.new,
    ),
  ];
}
