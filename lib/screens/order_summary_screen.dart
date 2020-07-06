import 'package:flutter/material.dart';
import 'package:foody/models/dish_data.dart';
import 'package:foody/models/dish_details_model.dart';
import 'package:foody/models/selected_dish_data.dart';
import 'package:foody/widgets/ordered_dish_widget.dart';
import 'package:foody/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class OrderSummaryScreen extends StatefulWidget {
  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  Widget setContentView() {
    Widget result = Consumer<DishData>(builder: (context, dishData, child) {
      return Container(
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
                  '${Provider.of<DishData>(context, listen: false).selectedDishes.length} Dishes -  ${Provider.of<DishData>(context, listen: false).selectedItemsCount} Items',
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
                  children:
                      List.generate(dishData.selectedDishes.length, (index) {
                    return OrderedDishWidget(
                      dish: dishData.selectedDishes[index],
                      onMinusTapped: () {
                        if (dishData.selectedDishes[index].addedCount > 1) {
                          Provider.of<DishData>(context, listen: false)
                              .removeItemInSelectedDishes(index);
                        }
                      },
                      onPlusTapped: () {
                        Provider.of<DishData>(context, listen: false)
                            .addItemInSelectedDishes(index);
                      },
                    );
                  }),
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
                            fontSize: 22.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'INR ${Provider.of<DishData>(context, listen: false).totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.green, fontSize: 22.0),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
//    Provider.of<OrderedDishData>(context, listen: false)
//        .setDishes(widget.selectedDishes);
//    Provider.of<OrderedDishData>(context, listen: false)
//        .setItemCount(widget.itemCount);
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
                    child: setContentView(),
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

/*
Container(
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
children: List.generate(
widget.selectedDishes.length, (index) {
return OrderedDishWidget(
dish: widget.selectedDishes[index],
onMinusTapped: () {},
onPlusTapped: () {},
);
}),
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
)*/
