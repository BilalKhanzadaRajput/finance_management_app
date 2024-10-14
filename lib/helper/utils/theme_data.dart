import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fm_app/helper/constants/dimensions_resource.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors_resource.dart';

class ThemeClass {
  static Color lightPrimaryColor = ColorResources.PRIMARY_COLOR;

  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: ThemeClass.lightPrimaryColor),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: ColorResources.PRIMARY_COLOR,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w400),
      displaySmall: TextStyle(
        color: ColorResources.BLACK_COLOR,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
        decorationColor: ColorResources.PRIMARY_COLOR,
        fontSize: Dimensions.D_18.sp
      ),
      displayMedium: TextStyle(
          color: ColorResources.HINT_TEXT_COLOR,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w300),
      headlineSmall: TextStyle(
          color: ColorResources.WHITE_COLOR,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w300),
    ),
  );
}
