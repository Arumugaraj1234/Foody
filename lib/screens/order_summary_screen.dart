import 'package:flutter/material.dart';
import 'package:foody/models/dish_details_model.dart';
import 'package:foody/widgets/rounded_button.dart';

class OrderSummaryScreen extends StatefulWidget {
  final List<DishDetailsModel> selectedDishes;
  final int selectedItemsCount;
  OrderSummaryScreen({this.selectedDishes, this.selectedItemsCount});
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.selectedDishes);
    print(widget.selectedItemsCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Order Summary',
          style: TextStyle(fontSize: 20.0, color: Colors.black54),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 3.0,
                          offset: Offset(1.0, 0.0))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF153110),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '2 Dishes - 2 Items',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: ListView(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0))),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Image.asset(
                                                'images/veg_icon.png'),
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Gobi Manchurian Dry',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'INR 20.00',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                '112 calories',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                      onPressed: () {}),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {}),
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
                                                'INR 20.00',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0))),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Image.asset(
                                                'images/nonveg_icon.png'),
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Spicy Chicken 65',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'INR 45.00',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                '250 calories',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                      onPressed: () {}),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {}),
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
                                                'INR 45.00',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 50.0,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Amount',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'INR 65.00',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 22.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: RoundedButton(
                color: Color(0xFF153110),
                title: 'Place Order',
                icon: null,
                onTapped: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
