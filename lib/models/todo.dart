import 'package:hive/hive.dart';

class Todo extends HiveObject {
  String task;
  bool isCompleted;

  Todo({required this.task, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {'task': task, 'isCompleted': isCompleted};
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      task: map['task'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final task = reader.readString();
    final isCompleted = reader.readBool();
    return Todo(task: task, isCompleted: isCompleted);
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.writeString(obj.task);
    writer.writeBool(obj.isCompleted);
  }
}
