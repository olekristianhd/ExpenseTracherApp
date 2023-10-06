/**
 * ExpenseItem Widget Documentation
 *
 * The `ExpenseItem` widget is responsible for displaying an individual expense item
 * within the Expense Tracker app's expenses list. It shows the title, amount, and date
 * of the expense.
 *
 * Table of Contents:
 * 1. ExpenseItem Widget
 * 2. User Interface
 *
 * 1. ExpenseItem Widget:
 *
 * - `ExpenseItem` is a StatelessWidget that displays an individual expense.
 * - It receives an `expense` object to display its details.
 *
 * 2. User Interface:
 *
 * - The user interface consists of a Card widget containing expense details.
 * - It displays the expense's title, amount, and date.
 *
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom Expense model and assets
import 'package:app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Build the UI for displaying an individual expense item
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the expense's title using large text style
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // Display the expense's amount in currency format
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    // Display the category icon and formatted date
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}