import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:dp_notes_spehere_08/widgets/progress_card.dart';
import 'package:flutter/material.dart';

import '../widgets/notes_to_do_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.kDefaultPadding,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NoteSphere', style: AppTextStyles.appTitle),
              const SizedBox(height: AppConstant.kDefaultPadding),
              //
              ProgressCard(completedTasks: 5, totalTasks: 5),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NotesTodoCard(
                    title: 'Notes',
                    description: '3 Notes',
                    icon: Icons.bookmark_add_outlined,
                  ),
                  NotesTodoCard(
                    title: 'To Do',
                    description: '2 Tasks',
                    icon: Icons.today_outlined,
                  ),
                  // Container(
                  //   width: 160,
                  //   height: 160,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: AppColors.kCardColor,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Icon(
                  //           Icons.bookmark_add,
                  //           color: AppColors.kWhiteColor,
                  //           size: 36,
                  //         ),
                  //         Text('Notes', style: AppTextStyles.appSubtitle),
                  //         Text(
                  //           '3 Notes',
                  //           style: AppTextStyles.appDescriptionSmall,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   width: 160,
                  //   height: 160,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: AppColors.kCardColor,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Icon(
                  //           Icons.calendar_month,
                  //           color: AppColors.kWhiteColor,
                  //           size: 36,
                  //         ),
                  //         Text('Notes', style: AppTextStyles.appSubtitle),
                  //         Text(
                  //           '3 Notes',
                  //           style: AppTextStyles.appDescriptionSmall,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today's Progress", style: AppTextStyles.appSubtitle),
                  Text('see all', style: AppTextStyles.appDescriptionLarge),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
