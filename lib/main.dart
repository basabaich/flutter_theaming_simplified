//
//File: main.dart
//
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(const MyApp()); //Always use "MyApp" as otherwise it's not working.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); //This line has to be added in "StatelesWidget()"

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses(), //We are calling the class / method "Expensees()"
    ); //MaterialApp
  }
}
