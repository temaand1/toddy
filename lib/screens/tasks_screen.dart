import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:toddyapp/components/task_screen_top_bar.dart';
import 'package:toddyapp/components/week_view.dart';
import 'package:toddyapp/models/task_data.dart';
import 'package:toddyapp/components/task_body.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  

final _auth = FirebaseAuth.instance;
  final quickAction = QuickActions();

  @override
  void initState() {
    super.initState();

    quickAction.setShortcutItems([
      ShortcutItem(type: 'add', localizedTitle: 'Add task', icon: 'add'),
      ShortcutItem(
          type: 'expired', localizedTitle: 'Expire tasks', icon: 'expired'),
    ]);

    quickAction.initialize((type) {
      if (type == 'add') {
        AddButton().createState().addTaskDialog(context, '',
            DateFormat.yMd().format(DateTime.now()), DateTime.now());
      } else if (type == 'expired') {
        Navigator.pushNamed(context, 'ExpireTasks');
      }
    });
  }

  // logOut() async {
  //   await _auth.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
        create: (BuildContext context) => TaskData(),
        child: Scaffold(
          floatingActionButton: AddButton(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(auth: _auth),
                WeekView(),
                TaskBody(),
              ],
            ),
          )),
        ));
  }
}
