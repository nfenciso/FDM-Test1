// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  int id;
  String task;
  String description;
  Todo({
    required this.id,
    required this.task,
    required this.description,
  });

  Todo copyWith({
    int? id,
    String? task,
    String? description,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'task': task,
      'description': description,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      task: map['task'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Todo(id: $id, task: $task, description: $description)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.task == task &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ task.hashCode ^ description.hashCode;
}
