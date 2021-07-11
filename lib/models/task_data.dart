import 'package:flutter/material.dart';
import 'package:toddyapp/components/task_model.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [Task(name: 'Long press to delete :)')];

  int get taskCount {
    return tasks.length;
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
