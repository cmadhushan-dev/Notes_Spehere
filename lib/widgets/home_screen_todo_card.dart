import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenTodoCard extends StatelessWidget {
  final String mainTitle;
  final bool isDone;
  final String date;
  final String time;
  const HomeScreenTodoCard({
    super.key,
    required this.mainTitle,
    required this.isDone,
    required this.date, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mainTitle, style: AppTextStyles.appDescriptionLarge),
                const SizedBox(height: 6),
                Text(
                  "${DateFormat.yMMMd().format(DateTime.parse(date))} ${DateFormat.Hm().format(DateTime.parse(time))}",
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            isDone
                ? Icon(Icons.done_all, color: Colors.green)
                : Icon(Icons.done, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
