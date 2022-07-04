import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

TextTheme appTextTheme = TextTheme(
  subtitle1: TextStyle(
    fontSize: 14.r,
    fontWeight: FontWeight.w300,
    color: AppColors.grey900,
  ),
  bodyText1: TextStyle(
    fontSize: 14.r,
    fontWeight: FontWeight.w300,
    color: AppColors.grey900,
    height: 2,
  ),
  caption: TextStyle(
    fontSize: 12.r,
    fontWeight: FontWeight.w400,
    color: AppColors.grey900,
  ),
  button: TextStyle(
    fontSize: 14.r,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  ),
  headline1: TextStyle(
    fontSize: 22.r,
    fontWeight: FontWeight.w400,
    color: AppColors.grey900,
    fontFamily: 'neirizi',
  ),
  headline2: TextStyle(
    fontSize: 16.r,
    fontWeight: FontWeight.w400,
    color: AppColors.grey700,
  ),
  headline3: TextStyle(
    fontSize: 13.r,
    fontWeight: FontWeight.w400,
    color: AppColors.grey700,
  ),
  // titleSmall: TextStyle(
  //   fontSize: 15.r,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.grey900,
  //   fontFamily: 'neirizi',
  // ),
  // titleMedium: TextStyle(
  //   fontSize: 18.r,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.grey900,
  //   fontFamily: 'neirizi',
  // ),
  // titleLarge: TextStyle(
  //   fontSize: 21.r,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.grey900,
  //   fontFamily: 'neirizi',
  // ),
  // bodySmall: TextStyle(
  //   fontSize: 14.r,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.grey700,
  // ),
  // bodyMedium: TextStyle(
  //   fontSize: 16.r,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.grey700,
  // ),
  // bodyLarge: TextStyle(
  //   fontSize: 18.r,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.grey700,
  // ),
);

class AppTextStyles {
//headers
  static final headline1 = TextStyle(
    fontSize: 64.sp,
    fontFamily: 'Lexend-Bold',
    fontWeight: FontWeight.w700,
    color: AppColors.grey900,
  );
//   static final headline2 = TextStyle(
//     fontSize: 48.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     color: AppColors.grey900,
//   );
//   static final headline3 = TextStyle(
//     fontSize: 32.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     //color: AppColors.onSurface,
//   );
//   static final headline4 = TextStyle(
//     fontSize: 24.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     color: AppColors.grey900,
//   );
//   static final headline5 = TextStyle(
//     fontSize: 20.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     color: AppColors.grey900,
//   );
//   static final headline6 = TextStyle(
//     fontSize: 18.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     color: AppColors.grey900,
//   );

//   static final headline7 = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     color: AppColors.grey900,
//   );

//   //subtitle
//   static final subtitle1 = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendMedium',
//     fontWeight: FontWeight.w500,
//     color: AppColors.grey900,
//   );
//   static final subtitle2 = TextStyle(
//     fontSize: 14.sp,
//     fontFamily: 'LexendRegular',
//     fontWeight: FontWeight.w400,
//     color: AppColors.grey900,
//   );

// //body
//   static final bodyText1 = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.grey900,
//   );
//   static final bodyText2 = TextStyle(
//     fontSize: 14.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.grey900,
//   );

//   //caption
//   static final caption = TextStyle(
//     fontSize: 12.sp,
//     fontFamily: 'LexendRegular',
//     fontWeight: FontWeight.w400,
//     color: AppColors.grey900,
//   );
//   //caption
//   static final captionLight = TextStyle(
//     fontSize: 12.sp,
//     fontFamily: 'LexendRegular',
//     fontWeight: FontWeight.w400,
//     color: AppColors.grey500,
//   );

//   //overline
//   static final overline = TextStyle(
//     fontSize: 12.sp,
//     fontFamily: 'LexendMedium',
//     fontWeight: FontWeight.w500,
//     color: AppColors.primary,
//   );

//   //inputTitle
//   static final inputTitle = TextStyle(
//     fontSize: 12.sp,
//     fontFamily: 'LexendMedium',
//     fontWeight: FontWeight.w400,
//     color: AppColors.grey900,
//   );

//   //button
//   static final buttonMd = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.white,
//   );

//   static final buttonSm = TextStyle(
//     fontSize: 14.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.primary,
//   );

// // text style in APPTitleTextField()
//   static final titleLarge = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w500,
//     color: AppColors.grey900,
//   );
//   static final textTextField = TextStyle(
//     fontSize: 14.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.grey900,
//   );
//   static final hintTextField = TextStyle(
//     fontSize: 14.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.grey500,
//   );

//   static final circleTitle = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendRegular',
//     fontWeight: FontWeight.w500,
//     color: AppColors.grey500,
//   );

//   static final tokenTitle = TextStyle(
//     fontSize: 8.sp,
//     fontFamily: 'LexendMedium',
//     fontWeight: FontWeight.w500,
//     color: AppColors.white,
//   );

//   // *******************************
//   static final searchBox = TextStyle(
//     fontSize: 14.sp,
//     fontFamily: 'LexendRegular',
//     fontWeight: FontWeight.w300,
//     color: AppColors.grey500,
//   );
//   static const titleSocial = TextStyle(
//     fontSize: 16,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w900,
//     color: AppColors.grey900,
//   );
//   static final bodyTextHint = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.grey300,
//   );
//   static final bodyTextTag = TextStyle(
//     fontSize: 16.sp,
//     fontFamily: 'LexendLight',
//     fontWeight: FontWeight.w300,
//     color: AppColors.primary,
//   );
//   static final underImage = TextStyle(
//     fontSize: 24.sp,
//     fontFamily: 'Lexend-Bold',
//     fontWeight: FontWeight.w700,
//     color: AppColors.white,
//   );
}
