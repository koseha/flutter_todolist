import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_todolist/features/todo_list.dart';
import 'package:flutter_todolist/models/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive 초기화
  await Hive.initFlutter();

  // TodoAdapter 등록
  Hive.registerAdapter(TodoAdapter());

  // Todo Box 열기
  await Hive.openBox<Todo>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO LIST',
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}
