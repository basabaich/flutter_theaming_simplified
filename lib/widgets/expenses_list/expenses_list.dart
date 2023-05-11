//
//File: expenses_list.dart in "Lib/widgets/expenses_list" folder.
//
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
//We also need to import the "expense.dart" file from the "models" folder
//as we are calling the "type" of class "Expense" in this "ExpensesList"
//class also.
import '../../../../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    //
    //while "returning" the build widget, we can use the "return Column()".
    //But, we will not use "Column()" widget here as the data inputted by
    //teh user may be very large and for large data if it gets created at
    //the begining, during loading of the application, there will be
    //performance issues. Moreover there is no integrated "Scroll bar" or
    //the data can not be scrollable.
    //
    //So, we will use "ListView()" widget as this widget will not have any
    //performance issue with it and will be scrollable automatically, when
    //data exceeds.
    //
    //However, here we will use "ListView.builder()"widget as though the
    //"ListView()" widget is automatically building a scrollable item list
    //but all the items are not updated in the application at a time. So there
    //may be some issues where data are more and to get the data in the screen
    //it may take some time.
    //In case of "ListView.builder()"widget all the data will be built based
    //on scrolling of the screen. more difference you can read from Google
    //on this topic.
    //
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
      //The "ListView.builder()" has many variables. The most important ones
      //are "itemBuilder" & "itemCount".
      //An unknown variable is passed on for the "itemBuilder". Here it is
      //"ctx". This will take different values starting from "0". So we have
      //put another variable which is called "index".
      //We can write the above itemBuilder widget as below two ways:-
      //(1) itemBuilder:(ctx, index)=> Text()
      //(2) itemBuilder:(ctx, index) {Text()}
      //Both will work.
      //Here the Text box will roll to different data based on the index &
      //display it. But here it will only show the differnt "title" data.
      //
    ); //ListView.builder
  }
}
