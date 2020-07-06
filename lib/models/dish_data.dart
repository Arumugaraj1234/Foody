import 'package:flutter/foundation.dart';
import 'package:foody/models/category_model.dart';
import 'package:foody/models/dish_details_model.dart';

class DishData extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  int _totalSelectedItems = 0;
  List<DishDetailsModel> _selectedDishes = [];
  double _totalPriceOfSelectedItems = 0;

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
    return _selectedDishes;
  }

  void setSelectedDishes() {
    _selectedDishes = [];
    _totalPriceOfSelectedItems = 0;
    for (var category in _categories) {
      for (var dish in category.dishes) {
        if (dish.addedCount > 0) {
          _totalPriceOfSelectedItems =
              _totalPriceOfSelectedItems + dish.totalPrice();
          _selectedDishes.add(dish);
        }
      }
    }
  }

  void addItemInSelectedDishes(int index) {
    _selectedDishes[index].addedCount++;
    _totalSelectedItems++;
    _totalPriceOfSelectedItems = 0;
    for (var dish in _selectedDishes) {
      _totalPriceOfSelectedItems =
          _totalPriceOfSelectedItems + dish.totalPrice();
    }
    notifyListeners();
  }

  void removeItemInSelectedDishes(int index) {
    _selectedDishes[index].addedCount--;
    _totalSelectedItems--;
    _totalPriceOfSelectedItems = 0;
    for (var dish in _selectedDishes) {
      _totalPriceOfSelectedItems =
          _totalPriceOfSelectedItems + dish.totalPrice();
    }
    notifyListeners();
  }

  double get totalPrice {
    return _totalPriceOfSelectedItems;
  }
}
