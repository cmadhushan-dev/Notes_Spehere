import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:hive/hive.dart';

class TodoService {
  List<ToDoModel> initialTodo = [
    ToDoModel(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDoModel(
      title: "Attend to pick nick",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: true,
    ),
    ToDoModel(
      title: "Assigment done",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: true,
    ),
  ];

  //create the database refernces for notes
  final _mytodobox = Hive.box('todos');
  //check whether the user is new
  Future<bool> isNewuser() async {
    return _mytodobox.isEmpty;
  }

  //method to create initial todos if the box is empty
  Future<void> createIntialTodos() async {
    if (_mytodobox.isEmpty) {
      await _mytodobox.put("todos", initialTodo);
    }
  }

  //load the todos from hive
  Future<List<ToDoModel>> loadTodos() async {
    final dynamic todos = await _mytodobox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<ToDoModel>().toList();
    }
    return [];
  }

  //mark the to as done
  Future<void> markAsDone(ToDoModel markTodo) async {
    try {
      final dynamic allTodos = await _mytodobox.get("todos");
      final int index = allTodos.indexWhere(
        (element) => element.id == markTodo.id,
      );
      allTodos[index] = markTodo;
      await _mytodobox.put("todos", allTodos);
    } catch (error) {
      print(error.toString());
    }
  }

  //method to add a todo
  Future<void> addTodo(ToDoModel todo) async {
    try {
      //load the all todos
      final dynamic allTodos = await _mytodobox.get("todos");
      //add  new todos to the alltodos
      allTodos.add(todo);
      //put the updated todos to the storage
      await _mytodobox.put("todos", allTodos);
    } catch (error) {
      print(error.toString());
    }
  }

  //method to delete a todo
  Future<void> deleteATodo(ToDoModel deletetodo) async {
    try {
      //load the all todos
      final dynamic allTodos = await _mytodobox.get("todos");
      allTodos.remove(deletetodo);
      await _mytodobox.put("todos", allTodos);
    } catch (ertt) {
      print(ertt.toString());
    }
  }
}
