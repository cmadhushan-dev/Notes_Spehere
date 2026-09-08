import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:dp_notes_spehere_08/pages/todo_inherted_class.dart';
import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/services/todo_service.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:dp_notes_spehere_08/widgets/progress_card.dart';

import 'package:flutter/material.dart';

import '../widgets/home_screen_todo_card.dart';
import '../widgets/notes_to_do_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> allNote = [];
  List<ToDoModel> allTodos = [];

  void _checkIfUserisNew() async {
    final bool isNewUserCheck =
        await NoteServices().isNewUser() || await TodoService().isNewuser();

    if (isNewUserCheck) {
      //if new user creta the intial notes
      await NoteServices().createInitalNotes();
      await TodoService().createIntialTodos();
    }

    loadNotes();
    loadTodos();
  }

  //method to load the note
  Future<void> loadNotes() async {
    final List<NoteModel> lodedNotes = await NoteServices().loadNotes();
    setState(() {
      allNote = lodedNotes;
    });
  }

  //method to load the todos
  Future<void> loadTodos() async {
    final List<ToDoModel> lodedTodos = await TodoService().loadTodos();
    setState(() {
      allTodos = lodedTodos;
    });
  }

  //this load the all data when page is openeing
  @override
  void initState() {
    super.initState();
    _checkIfUserisNew();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TodoInhertedClass(
      todos: allTodos,
      onTodosChanged: () {
        loadTodos();
      },
      child: Scaffold(
        body: Padding(
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
              ProgressCard(
                completedTasks: allTodos
                    .where((element) => element.isDone)
                    .length,
                totalTasks: allTodos.length,
              ),
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
                      description: "${allNote.length.toString()} Notes",
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
                      description: '${allTodos.length.toString()} Tasks',
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
              const SizedBox(height: 12),
              allTodos.isEmpty
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          AppRouter.routers.go("/todopage");
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 100),

                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Add Some task")],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: allTodos.length,
                        itemBuilder: (context, index) {
                          final ToDoModel todos = allTodos[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: HomeScreenTodoCard(
                              mainTitle: todos.title,
                              isDone: todos.isDone,
                              date: todos.date.toString(),
                              time: todos.time.toString(),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
