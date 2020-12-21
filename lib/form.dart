import 'package:flutter/material.dart';

import 'main.dart';

class TodoForm extends StatefulWidget {
  Todo todo;
  TodoForm(this.todo);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  String todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Todo'),
              onSaved: (String todoText) {
                widget.todo.todo = todoText;
              },
              validator: (String todoText) {
                if (todoText.length == 0) {
                  return "Fill in your todo";
                }
                return null;
              },
            ),
            RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
