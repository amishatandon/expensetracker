import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  }); // to accept the list of expenses as input.

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // automatically scrollable.
      itemCount: expenses.length, //item count for index.
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        //swipable or removable widget.
        key: ValueKey(
          expenses[index],
        ),
        onDismissed: (direction) {
          // pass a direction
          onRemoveExpense(
            expenses[index],
          );
        }, //change the _registeredExpense list on removing it.
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  } //we don't manage any data just output the expenses list.
}
