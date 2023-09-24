import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:intl/intl.dart";
import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //var _enteredTitle = '';
  //void _saveTitleInput(String inputValue) {
  //_enteredTitle = inputValue; // storing current value of text field in some variable.
  //}

  final _amountController = TextEditingController();

  final _titleController =
      TextEditingController(); // class optimized for handling user inputs

  DateTime?
      _selectedDate; // with initially not hold a value thats why ? to tell tha it will have value datetime or null.

  Category? _selectedCategory; // to store the values of category.

  void _presentDatePicker() async {
    //async and await for future events.
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        // this method will be executeed in future once the date has been picked(.then((value) => null) is one way.
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //print(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount =
        double.tryParse(_amountController.text); // has to a number not string.
    //double.tryparse a method takes string as input and returns a double if able to canvert or returns null if not.
    //means tryParse('hello') => null , tryParse('12.45') => 12.45
    final amountIsInvalid = enteredAmount == null ||
        enteredAmount <=
            0; // will be true when amount is null or less then zero.
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'please m ake sure a valid amount, date and category was entered'),
          actions: [
            //allows button to be displayed to close the window.
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('okay'),
            ),
          ],
        ),
      ); //show error message
      return; //any code there after won't be excuted.
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory!),
    ); // available in classes that extends state class.

    Navigator.pop(context); // to make sure overlay is closed.
  }

  @override
  void dispose() {
    _titleController.dispose(); // unnecessory memory will be taken.
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context)
        .viewInsets
        .bottom; //any extra ui that is overlapping ui from bottom.

    return LayoutBuilder(builder: (ctx, constraints) {
      // helps change layout of the screen.
      //print(constraints.minWidth);
      final width = constraints.maxWidth;
      //print(constraints.minHeight);
      //print(constraints.maxHeight);

      return SizedBox(
        height: double.infinity, //takes as much space as possible.
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16,
                keyboardspace + 16), // to not obstruct device features.
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          //onChanged: _saveTitleInput, // function triggered when value in text field changed.
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    //onChanged: _saveTitleInput, // function triggered when value in text field changed.
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton<Category>(
                        value:
                            _selectedCategory, // Use the selectedCategory variable
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem<Category>(
                                value: e,
                                child: Text(
                                  e.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              _selectedCategory =
                                  value; // Update the selectedCategory value
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(
                                      _selectedDate!), // exclaimation mark after a possibily null value tells that it will never be null.
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(
                                      _selectedDate!), // exclaimation mark after a possibily null value tells that it will never be null.
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton<Category>(
                        value:
                            _selectedCategory, // Use the selectedCategory variable
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem<Category>(
                                value: e,
                                child: Text(
                                  e.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              _selectedCategory =
                                  value; // Update the selectedCategory value
                            },
                          );
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
