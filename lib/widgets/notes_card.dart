import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final String noteCategory;
  final int numberOfNotes;
  const NotesCard({
    super.key,
    required this.noteCategory,
    required this.numberOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstant.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 2, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(noteCategory, style: AppTextStyles.appSubtitle),
          Text(
            "$numberOfNotes notes",
            style: AppTextStyles.appBody.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.kWhiteColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
