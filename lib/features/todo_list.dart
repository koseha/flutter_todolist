import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_todolist/features/todo_tile.dart';
import 'package:flutter_todolist/features/dialog_box.dart';
import 'package:flutter_todolist/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _newTaskController = TextEditingController();
  late Box<Todo> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todos');

    // 초기 데이터가 비어있으면 기본 데이터 추가
    if (todoBox.isEmpty) {
      todoBox.addAll([
        Todo(task: 'Make Tutorial', isCompleted: false),
        Todo(task: 'Do Exercise', isCompleted: false),
        Todo(task: 'Buy Groceries', isCompleted: true),
      ]);
    }
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      final todo = todoBox.getAt(index);
      if (todo != null) {
        todo.isCompleted = value ?? false;
        todo.save();
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      todoBox.deleteAt(index);
    });
  }

  void saveNewTask() {
    setState(() {
      todoBox.add(Todo(task: _newTaskController.text, isCompleted: false));
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
      body: ValueListenableBuilder<Box<Todo>>(
        valueListenable: todoBox.listenable(),
        builder: (context, box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final todo = box.getAt(index);
              if (todo == null) return const SizedBox.shrink();

              return TodoTile(
                todo: todo.task,
                isCompleted: todo.isCompleted,
                onTap: (value) => checkboxChanged(value, index),
                onDelete: (context) => deleteTask(index),
              );
            },
          );
        },
      ),
    );
  }
}
