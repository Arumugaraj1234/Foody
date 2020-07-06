import 'package:foody/models/category_model.dart';
import 'package:foody/models/dish_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foody/support_files/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:foody/models/network_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final ApiService shared = ApiService();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> getUserLoggedInStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(kUserLoggedInKey) ?? false;
  }

  void setUserLoggedInStatus(bool newValue) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(kUserLoggedInKey, newValue);
  }

  Future<List<String>> getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    //The order should be name, email, id
    List<String> defaultResult = ['', '', ''];
    return prefs.getStringList(kUserDetailsKey) ?? defaultResult;
  }

  void setUserDetails({List<String> userDetails}) async {
    final SharedPreferences prefs = await _prefs;
    print(userDetails);
    //The order should be name, email, id
    prefs.setStringList(kUserDetailsKey, userDetails);
  }

  void showToastMessage(
      {String message, ToastGravity place, Toast duration, Color bgColor}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: place,
        toastLength: duration,
        backgroundColor: bgColor);
  }

  Future<NetworkResponse> getAppInitDetails() async {
    NetworkResponse responseValue;
    try {
      http.Response response =
          await http.get('http://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
      String data = response.body;
      var jsonData = jsonDecode(data);
      if (response.statusCode == 200) {
        for (var restaurant in jsonData) {
          var tableMenuList = restaurant['table_menu_list'];
          List<CategoryModel> categories = [];
          for (var category in tableMenuList) {
            String categoryName = category['menu_category'];
            String categoryId = category['menu_category_id'];
            var categoryDishes = category['category_dishes'];
            List<DishDetailsModel> dishes = [];
            for (var dish in categoryDishes) {
              String dishId = dish['dish_id'];
              String dishName = dish['dish_name'];
              double dishPrice = dish['dish_price'];
              String dishImage = dish['dish_image'];
              double dishCalories = dish['dish_calories'];
              String dishDescription = dish['dish_description'];
              int dishType = dish['dish_Type'];
              var addOns = dish['addonCat'];
              bool isAddonAvailable = addOns.length == 0 ? false : true;
              DishDetailsModel dM = DishDetailsModel(
                  dishId: dishId,
                  dishName: dishName,
                  dishPrice: dishPrice,
                  dishImageLink: dishImage,
                  dishCalories: dishCalories,
                  dishDescription: dishDescription,
                  dishType: dishType,
                  isAddonAvailable: isAddonAvailable,
                  addedCount: 0);
              dishes.add(dM);
            }
            CategoryModel cM = CategoryModel(
                categoryId: categoryId,
                categoryName: categoryName,
                dishes: dishes);
            categories.add(cM);
          }
          responseValue = NetworkResponse(
              responseCode: 1,
              responseMessage: 'Success',
              responseData: categories);
        }
      } else {
        String message = 'Something went wrong. Please try again later';
        responseValue = NetworkResponse(
            responseCode: 0, responseMessage: message, responseData: null);
      }
    } catch (e) {
      String err = e.toString();
      responseValue = NetworkResponse(
          responseCode: 0, responseMessage: err, responseData: null);
    }
    return responseValue;
  }
}
