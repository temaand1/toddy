import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Task {
  String name;

  bool isDone;

  Task({
    required this.name,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
