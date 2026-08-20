import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class NoteServices {
  //deafult notes
  List<NoteModel> allNotes = [
    NoteModel(
      id: const Uuid().v4(),
      title: 'Meeting',
      category: 'Works',
      content: 'Discussed about the current status of the project ',
      date: DateTime.now(),
    ),
    NoteModel(
      id: const Uuid().v4(),
      title: 'Grocessry',
      category: 'home needs',
      content: 'sugaar,clone favours,milk poweder',
      date: DateTime.now(),
    ),
    NoteModel(
      id: const Uuid().v4(),
      title: 'Office',
      category: 'Office works',
      content: 'Audit repoort reading,salary sheets reviewing',
      date: DateTime.now(),
    ),
  ];

  //create the database refernces for notes
  final _myNotesBook = Hive.box('notes');

  //check wheter the user is a new user if new load intialzing data
  Future<bool> isNewUser() async {
    return _myNotesBook.isEmpty;
  }

  //method to create the intilanotes if user new
  Future<void> createInitalNotes() async {
    if (_myNotesBook.isEmpty) {
      //'notes' is the key
      await _myNotesBook.put('notes', allNotes);
    }
  }

  //method to load the notes
  Future<List<NoteModel>> loadNotes() async {
    final dynamic notes = _myNotesBook.get('notes');
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<NoteModel>().toList();
    }
    return [];
  }

  //loop through the all notes and create
  //an object where the key is the categary and the value is that category(for category notes)
  Map<String, List<NoteModel>> getNotesByCategoryMap(List<NoteModel> allNotes) {
    final Map<String, List<NoteModel>> noteByCategory = {};
    for (final note in allNotes) {
      if (noteByCategory.containsKey(note.category)) {
        noteByCategory[note.category]!.add(note);
      } else {
        noteByCategory[note.category] = [note];
      }
    }
    return noteByCategory;
  }
}
