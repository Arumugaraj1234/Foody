import 'package:flutter/material.dart';
import 'package:foody/models/dish_data.dart';
import 'package:foody/screens/home_screen.dart';
import 'package:foody/screens/login_screen.dart';
import 'package:foody/screens/mobile_input_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DishData>(
      create: (_) {
        return DishData();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Login.id,
        routes: {
          Login.id: (context) => Login(),
          MobileInputScreen.id: (context) => MobileInputScreen(),
          HomeScreen.id: (context) => HomeScreen()
        },
      ),
    );
  }
}
