import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:foody/models/category_model.dart';
import 'package:foody/models/dish_details_model.dart';

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
    notifyListeners();
  }

  void removeItem({int categoryIndex, int dishIndex}) {
    _categories[categoryIndex].dishes[dishIndex].addedCount--;
    _totalSelectedItems--;

    notifyListeners();
  }

  List<DishDetailsModel> get selectedDishes {
    List<DishDetailsModel> selectedDishes = [];
    for (var category in _categories) {
      for (var dish in category.dishes) {
        if (dish.addedCount > 0) {
          selectedDishes.add(dish);
        }
      }
    }
    return selectedDishes;
  }
}
