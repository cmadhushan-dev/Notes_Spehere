import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:dp_notes_spehere_08/pages/todo_inherted_class.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/utitlites/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  //intialzed the hive package
  await Hive.initFlutter();
  //register the adaptors
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(ToDoModelAdapter());
  //open hive boxes(name should be like table name)
  await Hive.openBox('notes');
  await Hive.openBox('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoInhertedClass(
      onTodosChanged: () {
        
      },
      todos: [],
      child: MaterialApp.router(
        title: 'NotesSpehere',
        debugShowCheckedModeBanner: false,
        //fonts overriding from the google
        theme: ThemeDataDetails.darkTheme.copyWith(
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
        ),
      
        routerConfig: AppRouter.routers,
      ),
    );
  }
}
