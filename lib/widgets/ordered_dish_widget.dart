import 'package:flutter/material.dart';
import 'package:foody/models/dish_details_model.dart';

class OrderedDishWidget extends StatelessWidget {
  final DishDetailsModel dish;
  final Function onPlusTapped;
  final Function onMinusTapped;

  OrderedDishWidget({this.dish, this.onPlusTapped, this.onMinusTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                  'images/${dish.dishType == 1 ? 'nonveg' : 'veg'}_icon.png'),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dish.dishName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'INR ${dish.dishPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${dish.dishCalories} calories',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: 150.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Color(0xFF153110),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onPressed: onMinusTapped),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${dish.addedCount}',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: onPlusTapped),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: 110.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'INR ${dish.totalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
