//
//File: expenses.dart in "Lib/widget" folder.
//
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
//We are calling class "ExpensesList()", we need to import that package
//as we will be using this class at the end to display the list of expenses
// in the body of this class i.e. "Expenses" class.
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

//
//
//
class Expenses extends StatefulWidget {
  const Expenses({super.key}); //This line of code need to be added in new
  //verison of flutter
  @override
  State<Expenses> createState() {
    //throw UnimplementedError();
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //We now create a list of expenses here below. We take the advantage fo the
  //fact that we know whenever a class is created, it also automatically
  //creates a "type" of that class & which comes within "<...>" and this
  //"type" holds valuable information of the object of that class.
  //
  //
  //Note as we have defined all the objects in the "expense.dart" file
  //within the class "Expense", so we need to import that file here at the
  //top and then we will call it's "type" with a variable.
  //
  //
  //We also call that "type" which holds object's information of that class
  //with a variable which start with like "_xyzabc". We treat this as a list
  //and so the format as below:-
  //
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ), //Expense
    //
    //
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ), //Expense
  ];

  //New method added to control plus button click event at AppBar
  //This function / method when called by clicking the plus sign
  //on the AppBar will open up a "Modal bottom sheet".
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      //In the "NewExpense" class the pattern of "Modal Bottom Sheet" is
      //designed & we are calling it from here through "NewExpense".
    );
  }

  //
  //
  //Adding a new method called "addExpense". We need to get the value of
  //"expense" of type "Expense". The method "_addExpense" will show an error
  // as it is never executed. Now this method we need to tie up with the
  //submit button code / login inside the class "NewExpense".
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);

      //We need to put "_registeredExpenses" inside the "setState()", so
      //that all dynamic changes by the user can be
      // recorded.
      //we include the "add" method here with the "_registeredExpenses" & in
      //the add method we pass on the variable against which we will get the
      //value i.e. "expense".
      //We will update the changed list in the "body" of this class i.e.
      //"Expenses" class, whenever the data is updated by clicking the "Submit"
      //button (& called by the "ExpensesList" class)
    });
  }

//
//

  @override
  Widget build(BuildContext context) {
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Expense Tracker',
          style: TextStyle(fontSize: 14),
        ), //Text
        elevation: 4,
        backgroundColor: Colors.amber.shade700,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
              size: 18,
            ), //Icon
          ) //IconButton
        ],
      ), //AppBar
      body: Column(children: [
        const Text('the chart'),
        Expanded(
          child: ExpensesList(expenses: _registeredExpenses),
          //We are using "ExpnasesList" class here & passing
          //"_registeredExpenses" to the "expenses" function.
          //We have also put an "Expanded" widget, as otherwise calling a "List"
          //within a "Column" will behave like a Column within a Column &
          //it will not display anything. So, always use "Expanded" widget
          //whenever you need to show the "List" inside a "Row" or a "Column".
        ), //Expanded
      ]), //column
    ); //scaffold
  }
}
