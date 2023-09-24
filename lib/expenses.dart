import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true, //to avoid device features.
      isScrollControlled: true, // the overlay will take complete height.
      context: context,
      builder: (ctxt) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex =
        _registerExpenses.indexOf(expense); //store the index of expense.
    setState(() {
      _registerExpenses.remove(expense); // to remove the expense list.
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex,
                  expense); // to insert the deleted expense back to its position.
            });
          },
        ),
      ),
    ); // to hide and display certain ui elements.
  }

  @override
  Widget build(BuildContext context) {
    //when the device is rotated build method is executed.
    final width = (MediaQuery.of(context).size.width);

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some'),
    );

    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerExpenses),
                // toolbar with app button => row()

                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  //set height constraints
                  child: Chart(
                      expenses:
                          _registerExpenses), //expanded makes the chart to only take as much width as availabe in row after sizing the other row children.
                ),
                // toolbar with app button => row()

                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
