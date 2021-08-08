import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final Function onCheckboxChanged;

  TaskTile({@required this.title, this.isDone, this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 20.0,
                decoration: isDone ? TextDecoration.lineThrough : null,
              )),
          Visibility(
              visible: isDone,
              child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  color: Colors.lightGreenAccent[400],
                  height: 15,
                  width: 30,
                  child: Text("done!",
                      style: TextStyle(
                        fontSize: 10.0,
                      ))))
        ],
      ),
      trailing: Checkbox(
        activeColor: Colors.purple,
        value: isDone,
        onChanged: onCheckboxChanged,
      ),
    );
  }
}
