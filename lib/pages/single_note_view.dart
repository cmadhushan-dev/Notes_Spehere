import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleNoteView extends StatelessWidget {
  final NoteModel noteDate;
  const SingleNoteView({super.key, required this.noteDate});

  @override
  Widget build(BuildContext context) {
    //formatted date
    final fromatedDate = DateFormat.yMMMd().format(noteDate.date);

    return Scaffold(
      appBar: AppBar(title: Text('Note')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(noteDate.title, style: AppTextStyles.appTitle),
              const SizedBox(height: 5),
              Text(
                fromatedDate,
                style: AppTextStyles.appDescriptionSmall.copyWith(
                  color: AppColors.kFabColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                noteDate.content,
                style: AppTextStyles.appTitle.copyWith(
                  color: AppColors.kWhiteColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
