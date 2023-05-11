//
//File: expense.dart in "Lib/Models" folder.
//
import 'package:flutter/material.dart';
//
//
import 'package:intl/intl.dart';
//Why this import is needed - please see bottom of this file.
//
//
//MOST IMPORTANT: Install "UUID" package from "pub.dev" website. To install
//just run in terminal the following command:-
//$ "flutter pub add uuid" (all in small letters).
//Until & unless you install the above third party package, you can not import
//the "uuid.dart" file in yor project
//
//
import 'package:uuid/uuid.dart';

//This package has to be included in this file
//so that "id" will be properly defined.
//
//
final formatter = DateFormat.yMd();
//To implement this code we need to import the "intl.dart" file at the above
//and also use a getter through "get" command which formats the date time to
//our requirement.
//
//
const uuid = Uuid(); //This line has to be added in new flutter
//Note that the second "Uuid" is with a caps begining.

enum Category { food, travel, leisure, work }
//A custom category is made with "enum".

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};
//For the above icons to be accessible , we need to import the "Material.dart"
//The above is an icon map structure of defining all icons in this class.

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //This line has to be added for proper working.

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //Adding method to the class:
  //We can use two ways to get to the methods:
  // (i) "getFormattedDate()"          - This is a method
  //
  // (ii) "String get formattedDate{
  //         return (put your formatted date)
  //       }"                         - This is a 'getter' version
  //
  //As formatting date manually in "Dart" is quite cumbersome, so we will take
  //help of a third party package "intl 0.18.0" from "pub.dev" site. more
  //details on this package we can get from the "pub.dev" site itself.
  //To use this third party package, first you need to impliment it in
  //"pubspec.yaml" file. To do this just run in the terminal & inside your
  //project directory "$ flutter pub add intl". This will add an extra line in
  //the "pubspec.yaml"file. Then you need to import this at the top of your
  //file where you are implimenting it as: "import 'package:intl/intl.dart';"
  String get formattedDate {
    return formatter.format(date);
  }
}
