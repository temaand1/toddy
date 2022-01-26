import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:toddyapp/components/task_body.dart';
import 'package:toddyapp/components/task_screen_top_bar.dart';
import 'package:toddyapp/components/week_view.dart';
import 'package:toddyapp/global/blocs/task_day_bloc/bloc/selected_day_bloc.dart';

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
        AddButton().createState().addTaskDialog(context);
      } else if (type == 'expired') {
        Navigator.pushNamed(context, 'ExpireTasks');
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    

    return BlocBuilder<SelectedDayBloc, DateTime>(
        builder: (context, selectDayState) {
      return Scaffold(
        floatingActionButton: AddButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          margin: MediaQuery.of(context).viewPadding,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(auth: _auth),
              WeekView(),
              TaskBody(),
            ],
          ),
        ),
      );
    });
  }
}
