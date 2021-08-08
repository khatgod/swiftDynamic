import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_data.dart';

class AddTaskSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTask;

    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Add Task',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 30.0,
            ),
            textAlign: TextAlign.center,
          ),
          TextField(
            cursorColor: Colors.purple,
            style: TextStyle(
              fontSize: 20.0,
            ),
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.purple,
                  width: 5.0,
                ),
              ),
            ),
            autofocus: true,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            padding: EdgeInsets.all(16.0),
            color: Colors.purple,
            child: Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              if (newTask != null) {
                Provider.of<TaskData>(context, listen: false).addTask(newTask);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
