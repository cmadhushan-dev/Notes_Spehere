import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool isToDo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TodoPage")),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isToDo = true;
                    });
                  },
                  child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Text(
                        "ToDo",
                        style: TextStyle(
                          color: isToDo ? AppColors.kWhiteColor : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isToDo = false;
                    });
                  },
                  child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Text(
                        "Complted",
                        style: TextStyle(
                          color: isToDo ? Colors.grey : AppColors.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
