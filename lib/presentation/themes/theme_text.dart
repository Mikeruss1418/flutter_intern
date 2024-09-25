// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_app/common/constants/size_constants.dart';
// import 'package:movie_app/common/extensions/size_extension.dart';

// import 'app_colors.dart';

// class ThemeText {
//   const ThemeText._();

//   static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
//   static TextStyle get _whiteHeadline6 => _poppinsTextTheme.titleLarge!.copyWith(
//         fontSize: (Sizes.dimen_20.sp).toDouble(),
//         color: Colors.white,
//       );
//        static TextStyle get whiteSubtitle1 => _poppinsTextTheme.titleMedium!.copyWith(
//         fontSize: Sizes.dimen_16.sp,
//         color: Colors.white,
//       );

//   static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyMedium!.copyWith(
//         color: Colors.white,
//         fontSize: Sizes.dimen_14.sp,
//         wordSpacing: 0.25,
//         letterSpacing: 0.25,
//         height: 1.5,
//       );

//   static getTextTheme() => TextTheme(
//         titleLarge: _whiteHeadline6,
//         titleMedium: whiteSubtitle1,
//         bodyMedium: whiteBodyText2,
//       );
// }
// extension ThemeTextExtendion on TextTheme {//it is a way of add new functionality to the existing class without changing the original class
//    TextStyle get royalBlueSubtitle1 => titleMedium!.copyWith(
//         color: AppColors.royalblue,
//         fontWeight: FontWeight.w600,
//       );
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';

import '../../common/constants/size_constants.dart';


class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.titleLarge!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headlineSmall!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.titleMedium!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteButton => _poppinsTextTheme.labelLarge!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
        headlineSmall: _whiteHeadline5,
        titleLarge: _whiteHeadline6,
        titleMedium: whiteSubtitle1,
        bodyMedium: whiteBodyText2,
        labelLarge: _whiteButton,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => titleMedium!.copyWith(
        color: AppColors.royalblue,
        fontWeight: FontWeight.w600,
      );

  TextStyle get greySubtitle1 => titleMedium!.copyWith(
        color: Colors.grey,
      );

  TextStyle get violetHeadline6 => titleLarge!.copyWith(
        color: AppColors.violet,
      );
      TextStyle get vulcanBodyText2 => bodyMedium!.copyWith(
        color: AppColors.vulcan,
      );
}