//
//File : new_expense.dart
//
//This file is for creating a structure / design of the "Modal Bottom Sheet"
//which will take inputs from the user. As this will take inputs from the
//user & is dynamic in nature so it is under "StatefulWidget" class.
//
//
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //
  //
  final _titleController = TextEditingController();
  //The "TextEditingController()" is an inbuild function of flutter which
  //mainly handles & stores all user inputs. So we have removed our earlier
  //created method & in place of that we will be using "TextEditingController()"
  //However, one important aspect is that every time the "Modal Bottom Sheet" is
  //closed, we need to tell flutter to delete this controller function so that
  //it dont occupy the space in mobile memory. So after "@override" we are using
  //the "dispose" method.

  //
  //We make another "TextEditingController()" for the "amount" argument
  //
  final _amountController = TextEditingController();
  //
  //
  void _presentDatePicker() {
    //We create a variable to create the "initialDate", "firstDate" &
    //"lastDate"
    final now = DateTime.now();
    //
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    //"ShowDatePicker" is a built in function in flutter.
  }

  //We can put this method which will take the date time picker icon pressed
  //event, before or after "@override" as it doesn't matter.
  //
  //
  @override
  //We need to dispose the "TextEditingController()" once the modal bottom
  //sheet is closed. So teh following procedure is followed if we call
  //"TextEditingController()". Note only "StatefulWidget" classes can call a
  //dispose method. The "StatelessWidget" class can't call this. So, while
  // using "TextEditingController()", we need to do it within StatefulWidget
  //classes only.
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          //This widget is a text field to allow the user to input some text
          TextField(
            //The below code comes into action whenever some text is changed in
            //the "title" textfield by the user. Here we are calling the method
            //as defined above (before @override) as "_saveTitleInput".
            //Here, we are not executing the method & hence we do not put this
            //method as "_saveTitleInput()", but we are pointing to it & hence
            //we are coding as "_saveTitleInput" where the "onChanged" function
            //points towards the "_saveTitleInput" & saves the title string
            //value in the "inputValue" variable.
            //
            //
            //Now instead of the "onChanged:" parameter, we will use the
            //"controller:" parameter - as we are using
            //"TextEditingController()" method
            controller: _titleController,
            //
            //
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ), //TextField
          //
          //
          //
          //we now put up a "Row()" here so that we can reduce the size of the
          //amount text field and put a "DateTime()" input function there.
          //Also, we put the second Text field inside the row's first widget
          //of the children. teh second widget will be the DateTime widget.
          Row(
            children: [
              //Similarly we create another textfield for amount
              Expanded(
                //As "TextField" have problem in rendering within Rows , so
                //we refactor this "TextField" with widget "Expanded"
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    //
                    //
                    prefixText: 'Rs. ',
                    //"PrefixText:" puts a currency notation the moment we click
                    // on "amount" text field to enter an amount. No backslash is
                    // necessary.
                  ), //InputDecoration
                ), //TextField
              ), //Expanded
              const SizedBox(
                width: 16,
              ), //SizedBox
              Expanded(
                //As two Rows can not be within one  another, so we refactor
                //this Row with widget "Expanded"
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //This will push the next widget to the extreme right of the
                  //Screen, i.e. the end of the screen.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //This will keep the next widget at the centre horizontally.
                  children: [
                    const Text('Selected date'),
                    IconButton(
                      onPressed: _presentDatePicker,
                      //This method is used as a pointer for teh "onPressed()"
                      //function.
                      icon: const Icon(Icons.calendar_month),
                    ), //IconButton
                  ],
                ), //Row
              ), //Expanded
            ],
          ), //Row

          const SizedBox(
            width: 16,
          ), //SizedBox
          //Putting a Sized box to get some space after "amount" text box.
//
//
          //     ],
          //   ), //Row

          Row(
            children: [
              const Spacer(
                flex: 12,
              ), //Spacer
              //Provided a "Spacer()" so that button locates from left to right
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  //This is an inbuilt method of flutter. Here the context is
                  //pased on from the "BuildContext". We pass on an annonymus
                  //"context" & hence keep the "()" empty, but in the second
                  //curly braces we pass the "Navigator.pop()" method which
                  //will automatically close the "Modal bottom sheet".
                },
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(26),
                  backgroundColor: MaterialStatePropertyAll(Colors.red[800]),
                ), //ButtonStyle
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 12),
                ), //Text
              ), //ElevatedButton
              const Spacer(
                flex: 1,
              ), //Spacer
              ElevatedButton(
                onPressed: () {
                  //ignore:
                  //  print(_titleController.text);
                  // print(_amountController);
                },
                style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(26),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.yellow[800])), //ButtonStyle
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 12),
                ), //Text
              ), //ElevatedButton
            ],
          ) //Row
        ],
      ), //Column
    ); //Padding
  }
}
