import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      background: AppColors.backgroundLight,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryLight,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight,
      elevation: 10,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.primaryLight.withOpacity(.5),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: AppColors.fontLight,
        fontSize: 12,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        color: AppColors.fontLight,
        fontSize: 14,
        height: 1.2,
      ),
      displayLarge: TextStyle(
        color: AppColors.fontLight,
        fontSize: 18,
        height: 1.25,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
    ),
    cardTheme: CardTheme(color: AppColors.primaryLight.withOpacity(.5)),
    primaryColor: AppColors.primaryLight,
    fontFamily: 'vazir',
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      background: AppColors.backgroundDark,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryLight,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
      elevation: 10,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.primaryDark.withOpacity(.5),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: AppColors.fontDark,
        fontSize: 12,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        color: AppColors.fontDark,
        fontSize: 14,
        height: 1.2,
      ),
      displayLarge: TextStyle(
        color: AppColors.fontDark,
        fontSize: 18,
        height: 1.25,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
    ),
    cardTheme: CardTheme(color: AppColors.primaryDark.withOpacity(.5)),
    primaryColor: AppColors.primaryDark,
    fontFamily: 'vazir',
    useMaterial3: true,
  );
}
