import 'package:foody/models/dish_details_model.dart';

class CategoryModel {
  String categoryId;
  String categoryName;
  List<DishDetailsModel> dishes;

  CategoryModel({this.categoryId, this.categoryName, this.dishes});
}
