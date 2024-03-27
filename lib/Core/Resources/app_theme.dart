import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      background: AppColors.backgroundLight,
    ),
    appBarTheme: const AppBarTheme(color: AppColors.primaryLight),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight,
      elevation: 10,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.primary.withOpacity(.5),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontFamily: 'neirizi',
        color: AppColors.primary,
        fontSize: 14,
      ),
    ),
    primaryColor: AppColors.primaryLight,
    fontFamily: 'vazir',
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      background: AppColors.backgroundDark,
    ),
    appBarTheme: const AppBarTheme(color: AppColors.primaryDark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
      elevation: 10,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.primary.withOpacity(.5),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontFamily: 'neirizi',
        color: AppColors.white,
        fontSize: 12,
      ),
    ),
    primaryColor: AppColors.primaryDark,
    fontFamily: 'vazir',
    useMaterial3: true,
  );
}
