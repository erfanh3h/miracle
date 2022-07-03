import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miracle/Core/Global/Core/global_binding.dart';
import 'package:miracle/Core/Models/user_model.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_theme.dart';
import 'package:miracle/Core/Routes/app_pages.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/days/Models/days.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Directory.current.path;
  // var path = await getApplicationDocumentsDirectory();
  // Hive.init(path.path);
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(DaysModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => OverlaySupport.global(
        child: GetMaterialApp(
          title: 'Miracle',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: Color(0XFF327565),
            primarySwatch: MaterialColor(
              const Color(0XFF327565).value,
              const {
                50: Color(0XFF327565),
                100: Color(0XFF327565),
                200: Color(0XFF327565),
                300: Color(0XFF327565),
                400: Color(0XFF327565),
                500: Color(0XFF327565),
                600: Color(0XFF327565),
                700: Color(0XFF327565),
                800: Color(0XFF327565),
                900: Color(0XFF327565),
              },
            ),
            canvasColor: AppColors.background,
            fontFamily: 'vazir',
            textTheme: appTheme,
          ),
          initialBinding: GlobalBinding(),
          initialRoute: AppRoutes.main,
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}
