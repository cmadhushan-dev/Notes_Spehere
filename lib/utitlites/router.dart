import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/pages/create_new_note.dart';
import 'package:dp_notes_spehere_08/pages/home_page.dart';
import 'package:dp_notes_spehere_08/pages/notes_by_category.dart';
import 'package:dp_notes_spehere_08/pages/notes_page.dart';
import 'package:dp_notes_spehere_08/pages/todo_page.dart';
import 'package:dp_notes_spehere_08/pages/update_note_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../pages/single_note_view.dart';

class AppRouter {
  static final routers = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: '/homePage',
    routes: [
      GoRoute(
        name: '/homePage',
        path: '/homePage',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      // todo page
      GoRoute(
        name: 'todopage',
        path: '/todopage',
        builder: (context, state) {
          return const TodoPage();
        },
      ),
      //notes  page
      GoRoute(
        name: 'notespage',
        path: '/notespage',
        builder: (context, state) {
          return const NotesPage();
        },
      ),
      //view notes ny category
      GoRoute(
        path: '/notebycategory',
        builder: (context, state) {
          final String category = state.extra as String;
          return NotesByCategory(category: category);
        },
      ),
      //crete new note
      GoRoute(
        path: "/createnewnote",
        builder: (context, state) {
          final bool isNewCategory = state.extra as bool;
          return CreateNewNote(isNewCategory: isNewCategory);
        },
      ),
      //edit page
      GoRoute(
        name: 'editnote',
        path: "/editNote",
        builder: (context, state) {
          final NoteModel editNote = state.extra as NoteModel;
          return UpdateNotePage(updateNote: editNote);
        },
      ),

      //route for single note
      GoRoute(
        name: "/SingleNoteView",
        path: "/SingleNoteView",
        builder: (context, state) {
          final NoteModel singleNote = state.extra as NoteModel;
          return SingleNoteView(noteDate: singleNote,);
        },
      ),
    ],
  );
}
