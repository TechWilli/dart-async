import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  final List<Future<Todo>> todoFutures =
      List.generate(5, (index) => fetchTodo(index + 1)).toList();

  final List<Todo> todoList = await Future.wait(todoFutures);

  print('todo: $todoList');
}

Future<Todo> fetchTodo(int todoId) async {
  try {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/$todoId'));

    final Todo todoResponse = Todo.fromMap(jsonDecode(response.body));

    print('response fetched successfully...');

    return todoResponse;
  } catch (e) {
    throw Exception('Opa, houve uma exceção');
  }
}

// criando uma classe model para mapear nossas requisições
class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      completed: map['completed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return toMap().toString();
    // return super.toString();
  }
}
