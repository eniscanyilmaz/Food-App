import 'package:flutter/material.dart';
import 'package:food_app/view/main_dashboard.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal-Box Gurme Lezzetler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainDashboard()
    );
  }
}
