import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toddyapp/models/task_model.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [Task(name: 'Long press to delete :)')];

  int get taskCount {
    return tasks.length;
  }

  String dayToShow = DateFormat.yMd().format(DateTime.now());

  void setCurrentDay(String date) {
    dayToShow = date;
    notifyListeners();
  }

  void currentDayUpdate(int day) {
    dayToShow =
        DateFormat.yMd().format(DateTime.now().add(Duration(days: day)));
    notifyListeners();
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }
}
