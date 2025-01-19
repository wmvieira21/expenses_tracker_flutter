import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpensesBucket> get buckets {
    return [
      ExpensesBucket.forCategory(expenses, Category.food),
      ExpensesBucket.forCategory(expenses, Category.leisure),
      ExpensesBucket.forCategory(expenses, Category.travel),
      ExpensesBucket.forCategory(expenses, Category.work)
    ];
  }

  double get maxTotalExpense {
    double maxTotalAmount = 0;

    for (final bucket in buckets) {
      if (maxTotalAmount < bucket.totalExpenses) {
        maxTotalAmount = bucket.totalExpenses;
      }
    }

    return maxTotalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Theme.of(context).cardTheme.margin,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).colorScheme.secondary,
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        spacing: 10,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 10,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                      fill: (maxTotalExpense == 0
                          ? 0
                          : bucket.totalExpenses / maxTotalExpense))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...buckets.map((bucket) {
                return Icon(categoryIcons[bucket.category]);
              }),
            ],
          )
        ],
      ),
    );
  }
}
