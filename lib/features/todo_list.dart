import 'package:flutter/material.dart';
import 'package:flutter_todolist/features/todo_tile.dart';
import 'package:flutter_todolist/features/dialog_box.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _newTaskController = TextEditingController();

  List<List<dynamic>> todos = [
    ['Make Tutorial', false],
    ['Do Exercise', false],
    ['Buy Groceries', true],
  ];

  void checkboxChanged(bool? value, int index) {
    setState(() {
      todos[index][1] = value ?? false;
    });
  }

  void deleteTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void saveNewTask() {
    setState(() {
      todos.add([_newTaskController.text, false]);
      _newTaskController.clear();
    });
    Navigator.pop(context);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _newTaskController,
        onSubmit: saveNewTask,
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODO LIST',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.orange,
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        backgroundColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoTile(
            todo: todos[index][0],
            isCompleted: todos[index][1],
            onTap: (value) => checkboxChanged(value, index),
            onDelete: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
