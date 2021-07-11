import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toddyapp/models/task_data.dart';
import 'package:toddyapp/screens/login.dart';
import 'package:toddyapp/screens/registration.dart';

import 'package:toddyapp/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Toddy());
}

class Toddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          'Login': (context) => Login(),
          'SingUp': (context) => Registration(),
        },
      ),
    );
  }
}
