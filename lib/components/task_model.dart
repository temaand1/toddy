import 'package:flutter/widgets.dart';

class Task with ChangeNotifier {
  final String name;
  bool isChecked;

  Task({required this.name, this.isChecked = false});

  void toggleDone() {
    isChecked = !isChecked;
  }
}
