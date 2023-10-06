/**
 * Chart Widget Documentation
 *
 * The `Chart` widget is responsible for displaying a bar chart representing
 * the distribution of expenses across different expense categories in the
 * Expense Tracker app.
 *
 * Table of Contents:
 * 1. Chart Widget
 * 2. Data Processing
 * 3. User Interface
 *
 * 1. Chart Widget:
 *
 * - `Chart` is a StatelessWidget that displays the expense distribution chart.
 * - It receives a list of `expenses` to calculate and visualize the distribution.
 *
 * 2. Data Processing:
 *
 * - The `buckets` property calculates expense totals for each category.
 * - The `maxTotalExpense` property finds the maximum total expense among categories.
 *
 * 3. User Interface:
 *
 * - The user interface consists of a bar chart with bars representing expense categories.
 * - The height of each bar is determined by the percentage of expenses in that category.
 * - The chart includes icons and a gradient background.
 *
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom ChartBar widget and Expense model
import 'package:app/widgets/chart/chart_bar.dart';
import 'package:app/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  // Calculate expense totals for each category
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  // Find the maximum total expense among categories
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Build the UI for the expense distribution chart
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets // for ... in
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}