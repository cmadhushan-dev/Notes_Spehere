import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onnewCategory;
  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onnewCategory,
  });

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,

      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            GestureDetector(
              onTap:widget.onNewNote ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CREATE A NEW NOTE ',
                    style: AppTextStyles.appDescriptionSmall,
                  ),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: widget.onnewCategory,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CREATE A NEW CATEGORY ',
                    style: AppTextStyles.appDescriptionSmall,
                  ),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
