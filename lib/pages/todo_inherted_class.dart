import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:flutter/material.dart';

class TodoInhertedClass extends InheritedWidget {
  final List<ToDoModel> todos ;
  final Function() onTodosChanged;

 const TodoInhertedClass({
    super.key,
    required super.child,
    required this.todos,
    required this.onTodosChanged,
  });

  static TodoInhertedClass? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoInhertedClass>();
  }

  @override
  bool updateShouldNotify(covariant TodoInhertedClass oldWidget) {
    return todos != oldWidget.todos;
  }
}
