import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:toddyapp/screens/expire_task_screen.dart';
import 'package:toddyapp/screens/login.dart';
import 'package:toddyapp/screens/tasks_screen.dart';
import 'package:toddyapp/screens/welcome_screen.dart';

import 'global/theme/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Toddy());
}

class Toddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithBLoc,
      ),
    );
  }

  Widget _buildWithBLoc(BuildContext context, ThemeState state) {
    return MaterialApp(
      theme: state.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        'Login': (context) => Login(),
        'TaskScreen': (context) => TasksScreen(),
        'ExpireTasks': (context) => ExpireTasks(),
        'AddButton': (context) => AddButton(),
      },
    );
  }
}
