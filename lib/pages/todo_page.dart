import 'package:dp_notes_spehere_08/helpers/snack_bars.dart';
import 'package:dp_notes_spehere_08/models/to_do_model.dart';
import 'package:dp_notes_spehere_08/services/todo_service.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:dp_notes_spehere_08/widgets/completed_tab.dart';
import 'package:dp_notes_spehere_08/widgets/todo_tab.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  //controller for tab bar
  late TabController _tapController;
  //todo service instance
  final TodoService _todoservice = TodoService();
  //lis of tods
  late List<ToDoModel> allTods = [];
  late List<ToDoModel> compltedTods = [];
  late List<ToDoModel> incompltedTods = [];
  //controller for add task
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tapController = TabController(length: 2, vsync: this);
    _checkIfUserNew();
  }

  @override
  void dispose() {
    super.dispose();
    _taskController.dispose();
    _tapController.dispose();
  }

  void _checkIfUserNew() async {
    final bool isNewUser = await _todoservice.isNewuser();
    if (isNewUser) {
      //create initla todos
      await _todoservice.createIntialTodos();
    }
    _loadTodos();
  }

  //load the todos
  Future<void> _loadTodos() async {
    final List<ToDoModel> lodedTodos = await _todoservice.loadTodos();
    setState(() {
      allTods = lodedTodos;
      print(" all todos lenght:${allTods.length}");
      //incomplted tods
      incompltedTods = allTods.where((todo) => !todo.isDone).toList();
      print("incomlted todos length: ${incompltedTods.length}");
      //complted todos
      compltedTods = allTods.where((todo) => todo.isDone).toList();
      print("complted todos lenght: ${compltedTods.length}");
    });
  }

  //method to add the task
  void addTask() async {
    try {
      if (_taskController.text.isNotEmpty) {
        final ToDoModel newTodo = ToDoModel(
          title: _taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );
        await TodoService().addTodo(newTodo);
        setState(() {
          allTods.add(newTodo);
          incompltedTods.add(newTodo);
        });
        if (mounted) {
          SnackBarsClass.showSnackBar(context, "Task Saved Succesfully");
          Navigator.of(context).pop();
        }
      }
    } catch (error) {
      if (mounted) {
        SnackBarsClass.showSnackBar(context, "Fail to Save");
      }
    }
  }

  //method to open the messeage bottomsheet
  void openModelBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.kCardColor,
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Add Task",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _taskController,
              style: TextStyle(color: AppColors.kWhiteColor, fontSize: 20),
              decoration: InputDecoration(
                hintText: "Entre your task",
                hintStyle: AppTextStyles.appDescriptionSmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.kFabColor),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(100),
                  ),
                ),
              ),
              onPressed: () {
                addTask();
                _taskController.clear();
              },
              child: Text("Add Task", style: AppTextStyles.appButton),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.kCardColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _taskController.clear();
              },
              child: Text("Cancel", style: AppTextStyles.appButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          dividerColor: AppColors.kBgColor,
          controller: _tapController,
          tabs: [
            Tab(child: Text("ToDo", style: AppTextStyles.appDescriptionSmall)),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescriptionSmall,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            AppRouter.routers.go("/homePage");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModelBottomSheet(context);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),

          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),

        child: Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tapController,
        children: [
          TodoTab(uncompltedTods: incompltedTods, compltedTodos: compltedTods),
          CompletedTab(
            compltedTodos: compltedTods,
            uncompltedTodos: incompltedTods,
          ),
        ],
      ),
    );
  }
}
