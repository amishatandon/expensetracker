import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }

  static Category getCategoryFromString(String categoryString) {
    switch (categoryString) {
      case 'work':
        return Category.work;
      case 'leisure':
        return Category.leisure;
      default:
        return Category.other;
    }
  }
}

class _ExpensesState extends State<Expenses> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _expensesCollection =
      FirebaseFirestore.instance.collection('expenses');
  final List<Expense> _registerExpenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    _expensesCollection.snapshots().listen((snapshot) {
      final expenses = snapshot.docs.map((document) {
        final data = document.data() as Map<String, dynamic>;
        return Expense(
          id: document.id,
          title: data['title'],
          amount: data['amount'],
          date: (data['date'] as Timestamp).toDate(),
          category: Expenses.getCategoryFromString(
              data['category']), // Use _getCategoryFromString here
        );
      }).toList();

      setState(() {
        _registerExpenses.clear();
        _registerExpenses.addAll(expenses);
      });
    });
  }

  void _addExpense(Expense expense) async {
    await _expensesCollection.add({
      'title': expense.title,
      'amount': expense.amount,
      'date': Timestamp.fromDate(expense.date),
      'category': expense.category.name,
    });
  }

  void _removeExpense(Expense expense) async {
    await _expensesCollection.doc(expense.id).delete();
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctxt) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
