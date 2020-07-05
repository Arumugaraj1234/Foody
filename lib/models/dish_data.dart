import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:foody/models/category_model.dart';

class DishData extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  int _totalSelectedItems = 0;

  int get categoryCount {
    return _categories.length;
  }

  int get selectedItemsCount {
    return _totalSelectedItems;
  }

  List<CategoryModel> get getCategories {
    return _categories;
  }

  void setCategories(List<CategoryModel> categories) {
    print(categories);
    _categories = categories;
    notifyListeners();
  }

  void addItem({int categoryIndex, int dishIndex}) {
    _categories[categoryIndex].dishes[dishIndex].addedCount++;
    _totalSelectedItems++;
    print(_totalSelectedItems);
    notifyListeners();
  }

  void removeItem({int categoryIndex, int dishIndex}) {
    _categories[categoryIndex].dishes[dishIndex].addedCount--;
    _totalSelectedItems--;
    print(_totalSelectedItems);
    notifyListeners();
  }

  /*
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
  */
}
