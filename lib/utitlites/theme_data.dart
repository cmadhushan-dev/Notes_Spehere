import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:flutter/material.dart';

class ThemeDataDetails {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBgColor,
    //in here usecopywith property to overwriite the original color
    colorScheme: ColorScheme.dark().copyWith(primary: AppColors.kWhiteColor),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.kWhiteColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData
    (
      backgroundColor: AppColors.kFabColor
    ),
  );
}
