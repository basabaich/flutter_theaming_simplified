//
//File : new_expense.dart
//
//This file is for creating a structure / design of the "Modal Bottom Sheet"
//which will take inputs from the user. As this will take inputs from the
//user & is dynamic in nature so it is under "StatefulWidget" class.
//
//
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //IMPORTED to enable us to read the chosen-
//date time format as below.
import '../models/expense.dart'; //Need to import this class as we are calling
//it

//date time format will be as "ymd()" i.e. year - month - day.
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense, //this need to be added / initiated in Super.key
  });
//
//
  //To enter new expenses, whenever we click on submit button , first we need
  //to create a function as below:
  final void Function(Expense expense) onAddExpense;
//
//
//

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
  //
  //
  //IMPORTANT - To store the Date time picked by the user, we first create an
  //variable as below. This is the "DateTime" variable.
  DateTime? _selectedDate;
  //When we code as "DateTime?" this means is the value a DateTime value or a
  //null. if it is not null, pass the value to the variable "_selectedDate"
  //
  //Define the dropdownbutton default value:
  Category _selectedCategory = Category.leisure;
  void _presentDatePicker() async {
    //We create a variable to create the "initialDate", "firstDate" &
    //"lastDate". Also to store the FUTURE datetime value if the user chooses
    //one, will be stored in the variable "pickedDate", we added "async" &
    //"await" commands in this function's line.
    //
    final now = DateTime.now();
    //
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      //"ShowDatePicker" is a built in function in flutter.
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    //We now use "setState()" function to get this date if user has picked one
    //through the below method.
    setState(
      () {
        _selectedDate = pickedDate;
      },
    );
  }

//
//
//validating user inputs
  void _submitExpenseData() {
    //First we will check if the amount entered is either 'zero' or an invalid
    // number i.e. any alphabets or signs were entered.
    //We will use "double.tryParse()" this will try to convert the value
    //entered in the _amountController field to a number. but if it fails to
    //do so, then "double.tryParse()" will return a null value. This is the
    //logic. We need to evaluate if the "enteredAmount" is null or not.
    //tryParse('Hello') will return null as the 'Hello' string can not be
    //changed to a double number.
    final enteredAmount = double.tryParse(_amountController.text);
    //
    //We now need to check if the "enteredAmount" is null or not.
    //We will also check if the "enteredAmount" is less than equal to zero or
    //not.
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //
    //Next we will check if the title filed is kept empty with below logic of
    //"isEmpty". Also we need to check the Boolean value of "amountIsInvalid"
    //is false or true. So this will be with an "OR" operator.
    //We also need to check if the date parameter is not entered. So we will
    //check with an OR operator if "_selectedDate" is null.
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //If the above sitution is true, we want to show an error meessage. We
      //will be using "AlertDialog()" in this case.
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input !!'),
          content: const Text(
            '''Please make sure that a valid title, amount, date & 
            category is entered !''',
          ), //Text
          //Using text within three single quotes for line breaks.
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(ctx); //This will close the error dialog
              },
            ) //TextButton
          ],
        ), //AlertDialog
      ); //showDialog
      return; //WE are writing this "return" here to lock this "showDialog"
      //widget & its associated codes, such that if due to code logic the
      //programming cycle enters this "showDialog" then after executing this
      //"showDialog" it will not execute any other code what so ever. As once
      //all the data are entered correctly, then the below codes will be
      //executed - which will add the new data in the main widget screen.
      //However, if the data are not entered correctly & the programming cycle
      //enters the "showDialog" then it will not read & execute the below
      //codes which are specifically written to add new data in the main
      //widget screen.
    }
    //we can access the "addNewExpense" function with the help of "Widget"
    //method as below. So, we will try to get access of "onAddExpense"
    //function from this widget class :-
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context); //This will close the 'Overlay' after data entered
    //correctly in it & the new data been added on the main screen.
  }

//
//
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

  //
  //

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      //From topmost position this will be @ 48 pixels. This will not
      //create hindarance to any sensors in the android.
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
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    //We also output the selected date in this above text box
                    //For this to be understandable & human read-able we need
                    //to import the "intl" class which we used in "expense.dart"
                    //file.
                    //IMPORTANT: the code above means If "_selectedDate"
                    //equals to "null", the text will show 'No date selected'
                    //else (i.e. ":" Colon sign) command "formatter" will
                    //format the date selected for human values & display.
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
          const SizedBox(height: 16),
          Row(
            children: [
              //Dropdownbutton defined here with the help of a map() method
              //
              DropdownButton(
                  value: _selectedCategory, //Using default category to display
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          //added "value" which will not be visble in our app
                          // but this will store the value of the dropdownbutton
                          //chosen by the user internally.
                          value: category,
                          child: Text(
                            category.name.toUpperCase(), //No need to use a
                            //".toString()" here as "name" itself is a string.
                            //However, we set the name in uppercase by default.
                          ), //Text
                        ), //DropdownMenuItem
                      )
                      .toList(),
                  onChanged: (value) {
                    // print(value);
                    //Use dynamic changing method i.e. "setState()" here
                    if (value == null) {
                      return; // This means program will not execute any
                      //further codes inside this "onChanged" method. Else it
                      //will go from here to "setState()".
                    }
                    setState(() {
                      _selectedCategory = value; //This will report an error
                      //as in the event user didn't selected a value then it's
                      //a null. So we are doint an "if" check at begining.
                    });
                  }), //DropdownButton
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
                  _submitExpenseData();
                  //ignore:
                  //  print(_titleController.text);
                  // print(_amountController);
                  // widget.onAddExpense(Expense(title: _titleController, amount: _amountController, date: _selectedDate, category: _))
                },
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(26),
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.yellow[800],
                  ), //MaterialStatePropertyAll
                ), //ButtonStyle
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
