import 'package:flutter/material.dart';
import 'package:flutter_stals/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Django Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];

  _retrieveTodos() async {
    todos = [];

    String url = "http://127.0.0.1:8000/todos/";
    final response = json.decode((await http.get(Uri.parse(url))).body);
    for (var element in response) {
     todos.add(Todo.fromMap(element));
    }
    setState(() {
    });
  }

  _deleteTodo(int id) async {
    await http.delete(Uri.parse("http://127.0.0.1:8000/todos/${id.toString()}/delete/"));
    _retrieveTodos();
  }

  _addTodo() async {
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    await http.post(Uri.parse("http://127.0.0.1:8000/todos/create/"), body: {'task': 'Task ${randomNumber.toString()}', 'description': 'Description of Task ${randomNumber.toString()}'});
    _retrieveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveTodos();
        },
        child: Column(children: [
          ElevatedButton(onPressed: _retrieveTodos, child: const Text("View All Todos")),
          SizedBox(
            height: 600,
            child: Card(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      tileColor: Color.fromARGB(255, 215, 215, 78),
                      leading: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(children: [
                          Expanded(
                            flex: 2,
                            child: Text(todos[index].task),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: SingleChildScrollView(scrollDirection: Axis.horizontal,child: Text(todos[index].description)),
                          )
                        ],),
                      ),
                      trailing: FractionallySizedBox(
                        widthFactor: 0.1,
                        child: IconButton(icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteTodo(todos[index].id);
                          },
                        ),
                      ),
                    );
                  }),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        }, //_addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
