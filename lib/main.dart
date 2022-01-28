import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:toddyapp/global/blocs/task_day_bloc/bloc/selected_day_bloc.dart';
import 'package:toddyapp/global/theme/app_themes.dart';
import 'package:toddyapp/screens/expire_task_screen.dart';
import 'package:toddyapp/screens/login.dart';
import 'package:toddyapp/screens/tasks_screen.dart';
import 'package:toddyapp/screens/welcome_screen.dart';
import 'package:toddyapp/services/get_initial_theme.dart';

import 'global/blocs/theme_bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetInitialTheme.init();

  runApp(Toddy());
}

class Toddy extends StatelessWidget {
  final String? initTheme = GetInitialTheme().getTheme();
  final String? initThemeMode = GetInitialTheme().getThemeMode();

  @override
  Widget build(BuildContext context) {
    AppTheme themeData = getInittheme(initTheme);
    ThemeMode themeMode = getThemeMode(initThemeMode!);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(themeData, themeMode),
        ),
        BlocProvider(
          create: (context) => SelectedDayBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithBLoc,
      ),
    );
  }

  Widget _buildWithBLoc(BuildContext context, ThemeState state) {
    return MaterialApp(
      theme: state.themeData,
      themeMode: state.themeMode,
      darkTheme: ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
          colorScheme: state.themeData!.colorScheme),
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
