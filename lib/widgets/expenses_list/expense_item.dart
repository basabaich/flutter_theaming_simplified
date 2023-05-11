//
//File: expenses_item.dart in "Lib/widgets/expenses_list" folder.
//

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  //
  //To call the class "ExpenseItem" & the argument defined here i.e. "expense"
  //we need to define the above constructor in such a way so that argument
  //"expense" is a position argument & "super.key" is a named argument.
  //With above format you can call "ExpenseItem(expenses[index])" from another
  //file & get the data. Else there will be an error if "expense" is not a
  //position argument.
  //
  //In case you are calling a final argument, in the above line you need to
  //add: "required this.argument".
  //We can write the above as :
  //const ExpenseItem(this.expense, {super.key});
  //Here the first argument is a position argument, so don't require an
  //annotation viz. "required" before it.
  //The second argument i.e. "super.key" is a named parameter & hence within
  //a curly braces.

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '\$ ${expense.amount.toStringAsFixed(2)}',
                    //If we put "2" here in the fucntion "toStringAsFixed(2)",
                    //the decimal places are of two digits.
                    //To indicate a '$' sign in front of the value as the
                    //'Currency' notation, we need to first keep the whole
                    //statement inside the "Text" widget within single
                    //aphos-tophie i.e. 'xxx' sign. Then we cover the whole
                    //text with curly brackets as below:
                    // '{expense.amount.toStringAsFixed(2)}'
                    //We then put the 'injection syntax' in front to tell flutter
                    // that the whole text within the curly bracket is a value
                    // & must not be treated as a text. Like below:
                    //  '${expense.amount.toStringAsFixed(2)}'
                    //Now if we want to put a dollar sign ($) to be displayed,
                    //we need to do that with a backslash i.e. "/$". So the
                    // complete code line now looks as:
                    // '\$${expense.amount.toStringAsFixed(2)}'
                    //Note: If we put a space between both the dollar signs,
                    // there will be a space between the dollar sign & the
                    //amount. Also if we want to provide some other currency
                    // sign, we need to replace the first dollar sign with
                    //that particular currency sign.
                    //
                    //
                  ), //Text
                  const Spacer(),
                  //Widget "Spacer()" can be added anywhere to get some extra
                  //space. Here if we don't use this widget then our next
                  //widget displays just after the amount value & without any
                  //space.
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      //We are using the icons which are defined in the Expense
                      //class & so we are calling "categoryIcons" & then passing
                      //enum values through "expense.category"
                      //
                      const SizedBox(width: 8),
                      Text(expense.formattedDate)
                    ],
                  ), //Row
                ],
              ) //Row
            ],
          ) //Column
          //"Refactor" the "Text" widget with the "Padding" widget to get some
          //'margin' between the "Card" widgets. This is done with keeping the
          //cursor over the Text widget and right click it. In the popped up
          //menu there will be "Refactor" - where we need to click.
          ), //Padding
    ); //Card
  }
}
