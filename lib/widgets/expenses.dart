import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
      tittle: 'Insurance',
      amount: 12.6,
      category: Category.food,
      date: DateTime.now(),
    ),
    Expense(
      tittle: 'Internet',
      amount: 8.6,
      category: Category.leisure,
      date: DateTime.now(),
    )
  ];

  void _addExpenseList(Expense exp) {
    setState(() {
      _expensesList.add(exp);
    });
  }

  void _removeExpense(Expense exp) {
    final int indexExpense = _expensesList.indexOf(exp);

    setState(() {
      _expensesList.remove(exp);
    });

    _undoExpenseRemoval(indexExpense, exp);
  }

  void _undoExpenseRemoval(int indexExpense, Expense exp) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Expense deleted!'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _expensesList.insert(indexExpense, exp);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(onSaveNewExpenseList: _addExpenseList),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text('No expenses found yet. Start adding now!'));

    final widthScreen = MediaQuery.of(context).size.width;

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _expensesList, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: widthScreen < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expenses: _expensesList),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expensesList)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
