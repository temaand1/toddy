import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:toddyapp/constants.dart';

class TaskTile extends StatefulWidget {
  final bool isChecked;
  final String text;
  final onTap;
  final onLongTap;
  final int codePoint;

  const TaskTile(
      {this.isChecked = false,
      required this.text,
      required this.onTap,
      this.onLongTap,
      required this.codePoint});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete task ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: widget.onLongTap,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      leading: Icon(
        IconData(widget.codePoint, fontFamily: 'MaterialIcons'),
        color: widget.isChecked ? kMainBlue : kAccentColor,
      ),
      title: Text(
        widget.text,
        style: TextStyle(
            decoration: widget.isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: kAccentColor,
        value: widget.isChecked,
        onChanged: widget.onTap,
      ),
    );
  }
}
