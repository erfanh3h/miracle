import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Components/hive_component.dart';
import 'package:miracle/Core/Resources/app_translates.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Pages/splash.dart';
import 'package:miracle/Core/Resources/app_theme.dart';
import 'package:miracle/Core/Routes/app_pages.dart';

import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveComponent().init();
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
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
            Locale("en", "US"),
          ],
          locale: const Locale("fa", "IR"), //
          getPages: AppPages.pages,
          home: const SplashPage(),
          themeMode: ThemeMode.light,
          translations: AppTranslations(),
          defaultTransition: Transition.fadeIn,
        ),
      ),
    );
  }
}
