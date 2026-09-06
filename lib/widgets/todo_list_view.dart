import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';

class TodoListView extends StatefulWidget {
  final String title;
  final DateTime dateCreatedRecord;
  final DateTime timeCretedRecord;
  final bool isComplted;
  final  Function() onCheckBoxChenged;
  const TodoListView({
    super.key,
    required this.title,
    required this.dateCreatedRecord,
    required this.timeCretedRecord,
    required this.isComplted,
    required this.onCheckBoxChenged,
  });

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.kWhiteColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: AppTextStyles.appDescriptionSmall),
                Row(
                  children: [
                    Text(
                      "${widget.dateCreatedRecord.day}/${widget.dateCreatedRecord.month}/${widget.dateCreatedRecord.year}",
                      style: AppTextStyles.appDescriptionSmall,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "${widget.timeCretedRecord.hour}.${widget.timeCretedRecord.minute}.${widget.timeCretedRecord.second}",
                      style: AppTextStyles.appDescriptionSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Checkbox(value: widget.isComplted, onChanged: (value) =>widget.onCheckBoxChenged()),
        ],
      ),
    );
  }
}
