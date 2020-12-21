import 'package:flutter/material.dart';

import 'form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

enum TodoStatus { notDone, done }

class Todo {
  String todo;
  TodoStatus status;

  Todo(this.todo, this.status);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [
    Todo('Come to class', TodoStatus.notDone),
    Todo("Eat McDonald's", TodoStatus.done)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Todo todo = Todo('', TodoStatus.notDone);
            await showDialog(
                context: context, child: AlertDialog(content: TodoForm(todo)));
            setState(() {
              if(todo.todo.length > 0) {
                todos.add(todo);
              }
            });
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = todos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 12.0,
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(todo.todo,
                              style: TextStyle(
                                fontSize: 30.0,
                              )),
                          Checkbox(
                              value: todo.status == TodoStatus.done,
                              onChanged: (bool checked) {
                                setState(() {
                                  if (checked) {
                                    todo.status = TodoStatus.done;
                                  } else {
                                    todo.status = TodoStatus.notDone;
                                  }
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
