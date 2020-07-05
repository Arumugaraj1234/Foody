import 'package:flutter/material.dart';
import 'package:foody/models/dish_details_model.dart';

class DishDetailsWidget extends StatelessWidget {
  final DishDetailsModel dishDetail;
  final Function onPlusTapped;
  final Function onMinusTapped;

  DishDetailsWidget({this.dishDetail, this.onPlusTapped, this.onMinusTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                    'images/${dishDetail.dishType == 1 ? 'nonveg' : 'veg'}_icon.png'),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dishDetail.dishName,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'INR ${dishDetail.dishPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${dishDetail.dishCalories.toStringAsFixed(2)} Calories',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    dishDetail.dishDescription,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 150.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
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
                              '${dishDetail.addedCount}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
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
                  Visibility(
                    visible: dishDetail.isAddonAvailable,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Customizations Available',
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100.0,
                width: 70.0,
                foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(dishDetail.dishImageLink),
                      fit: BoxFit.fill),
                ),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
