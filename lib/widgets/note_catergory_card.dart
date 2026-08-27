import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';

class NoteCatergoryCard extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final Future Function() removeNotes;
  final Future Function() editNotes;
  final void Function() viewSignleNote;
  const NoteCatergoryCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.removeNotes,
    required this.editNotes,
    required this.viewSignleNote,
  });

  @override
  State<NoteCatergoryCard> createState() => _NoteCatergoryCardState();
}

class _NoteCatergoryCardState extends State<NoteCatergoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: widget.editNotes,

                  icon: Icon(Icons.edit_outlined),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: widget.removeNotes,

                  icon: Icon(Icons.delete_outlined),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                widget.viewSignleNote();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.noteTitle,
                    style: AppTextStyles.appSubtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.noteContent,
                    style: AppTextStyles.appDescriptionSmall.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
