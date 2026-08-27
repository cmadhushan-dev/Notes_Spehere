import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
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
  int countOfNote = 0;
  //function get the count of the categaries
  Future<void> getCountOfNotes() async {
    final countOfNotes = await NoteServices().returnTotaoCountOfCategaries();
    setState(() {
      countOfNote = countOfNotes;
    });
  }

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
                  GestureDetector(
                    onTap: () {
                      //go to the notes page (no need t a buildcontext)
                      AppRouter.routers.push('/notespage');
                      // //go to the notes page
                      // GoRouter.of(context).push('/notespage');
                    },
                    child: NotesTodoCard(
                      title: 'Notes',
                      description: countOfNote.toString(),
                      icon: Icons.bookmark_add_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //go to the todo list (no need t a buildcontext)
                      AppRouter.routers.push('/todopage');
                      // //go to the todo list
                      // GoRouter.of(context).push('/todopage');
                    },
                    child: NotesTodoCard(
                      title: 'To Do',
                      description: '2 Tasks',
                      icon: Icons.today_outlined,
                    ),
                  ),
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
