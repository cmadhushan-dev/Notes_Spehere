import 'package:dp_notes_spehere_08/helpers/snack_bars.dart';
import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:dp_notes_spehere_08/services/todo_service.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/widgets/todo_list_view.dart';
import 'package:flutter/material.dart';

import '../utitlites/text_styles.dart';

class TodoTab extends StatefulWidget {
  final List<ToDoModel> uncompltedTods;
  final List<ToDoModel> compltedTodos;
  const TodoTab({
    super.key,
    required this.uncompltedTods,
    required this.compltedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  //method to mark a to as done
  void markTodoAsDone(ToDoModel doneDoto) async {
    try {
      final ToDoModel updatedTodo = ToDoModel(
        title: doneDoto.title,
        date: doneDoto.date,
        time: doneDoto.time,
        isDone: true,
      );

      await TodoService().markAsDone(updatedTodo);
      //snackBar
      if (mounted) {
        SnackBarsClass.showSnackBar(context, 'markAsDone');
      } else {
        return;
      }
      setState(() {
        widget.uncompltedTods.remove(updatedTodo);
      });
      AppRouter.routers.go("/todopage");
    } catch (er) {
      print(er.toString());
      if (mounted) {
        SnackBarsClass.showSnackBar(context, 'Fail to mark as Done');
      } else {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.uncompltedTods.sort((a, b) => a.time.compareTo(b.time));
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          widget.uncompltedTods.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      "Add Some task",
                      style: AppTextStyles.appDescriptionSmall.copyWith(
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: widget.uncompltedTods.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final ToDoModel todoList = widget.uncompltedTods[index];
                      return Dismissible(
                        key: Key(todoList.id.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            widget.uncompltedTods.removeAt(index);
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
                            isComplted: false,
                            onCheckBoxChenged: () {
                              markTodoAsDone(todoList);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
