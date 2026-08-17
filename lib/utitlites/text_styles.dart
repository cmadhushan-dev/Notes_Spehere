import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {

  //app main title
  static const   TextStyle appTitle = TextStyle(
    fontSize: 28,
    color:AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );

//app subtitles
  static const TextStyle appSubtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color:AppColors.kWhiteColor,
  );

//app description
  static const  TextStyle appDescriptionLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color:AppColors.kWhiteColor,
  );
 //app description small
  static const TextStyle appDescriptionSmall = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle appBody = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 16,
  );

  static const TextStyle appButton = TextStyle(
    fontSize: 16,
    color:AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );
}