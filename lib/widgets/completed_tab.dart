import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:dp_notes_spehere_08/pages/todo_inherted_class.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';
import '../helpers/snack_bars.dart';
import '../services/todo_service.dart';
import '../utitlites/router.dart';
import 'todo_list_view.dart';

class CompletedTab extends StatefulWidget {
  final List<ToDoModel> uncompltedTodos;
  final List<ToDoModel> compltedTodos;
  const CompletedTab({
    super.key,
    required this.compltedTodos,
    required this.uncompltedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  //method to mark a to as uncomplted
  void markTodoAsUnComplted(ToDoModel unCompltedDoto) async {
    try {
      final ToDoModel updatedTodo = ToDoModel(
        title: unCompltedDoto.title,
        date: unCompltedDoto.date,
        time: unCompltedDoto.time,
        isDone: false,
      );

      await TodoService().markAsDone(updatedTodo);
      //snackBar
      if (mounted) {
        SnackBarsClass.showSnackBar(context, 'markAsUnCompleted');
      } else {
        return;
      }
      setState(() {
        widget.compltedTodos.remove(unCompltedDoto);
      });

      AppRouter.routers.go("/todopage");
    } catch (er) {
      if (mounted) {
        SnackBarsClass.showSnackBar(context, 'Fail to mark as unDone');
      } else {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.compltedTodos.sort((a, b) => a.time.compareTo(b.time));
    });
    return TodoInhertedClass(
      todos: widget.compltedTodos,
      onTodosChanged: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            widget.compltedTodos.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        "Complte Some task",
                        style: AppTextStyles.appDescriptionSmall.copyWith(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.compltedTodos.length,
                      addAutomaticKeepAlives: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ToDoModel todoList = widget.compltedTodos[index];
                        return Dismissible(
                          key: Key(todoList.id.toString()),
                          onDismissed: (direction) {
                            setState(() {
                              widget.compltedTodos.removeAt(index);
                              TodoService().deleteATodo(todoList);
                            });
                            SnackBarsClass.showSnackBar(
                              context,
                              "deleted sucsfully",
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TodoListView(
                              title: todoList.title,
                              dateCreatedRecord: todoList.date,
                              timeCretedRecord: todoList.time,
                              isComplted: true,
                              onCheckBoxChenged: () {
                                markTodoAsUnComplted(todoList);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
