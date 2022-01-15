import 'package:flutter/material.dart';
import 'package:toddyapp/components/expire_screen_top_bar.dart';
import 'package:toddyapp/components/expire_task_body.dart';

class ExpireTasks extends StatefulWidget {
  const ExpireTasks({Key? key}) : super(key: key);

  @override
  _ExpireTasksState createState() => _ExpireTasksState();
}

class _ExpireTasksState extends State<ExpireTasks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          ExpireTopBar(),
          ExpireTaskbody(),
        ],
      ),
    ));
  }
}
