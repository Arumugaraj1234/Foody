import 'package:flutter/foundation.dart';
import 'package:foody/models/category_model.dart';
import 'package:foody/models/dish_details_model.dart';

class OrderedDishData extends ChangeNotifier {
  List<DishDetailsModel> _dishes = [];
  int _totalSelectedItems = 0;

  int get dishesCount {
    return _dishes.length;
  }

  int get selectedItemsCount {
    return _totalSelectedItems;
  }

  List<DishDetailsModel> get getDishes {
    return _dishes;
  }

  void setDishes(List<DishDetailsModel> dishes) {
    _dishes = dishes;
    notifyListeners();
  }

  void setItemCount(int count) {
    _totalSelectedItems = count;
    notifyListeners();
  }

  void addItem({int dishIndex}) {
    _dishes[dishIndex].addedCount++;
    _totalSelectedItems++;
    notifyListeners();
  }

  void removeItem({int dishIndex}) {
    _dishes[dishIndex].addedCount--;
    _totalSelectedItems--;

    notifyListeners();
  }
}
