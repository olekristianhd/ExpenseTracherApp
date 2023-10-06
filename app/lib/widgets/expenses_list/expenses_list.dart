/**
 * ExpensesList Widget Documentation
 *
 * The `ExpensesList` widget is responsible for displaying a list of expenses in the Expense Tracker app.
 * It provides the ability to remove and edit individual expenses within the list.
 *
 * Table of Contents:
 * 1. ExpensesList Widget
 * 2. User Interface
 *
 * 1. ExpensesList Widget:
 *
 * - `ExpensesList` is a StatelessWidget that displays a list of expenses and allows users to interact with them.
 * - It receives a list of `expenses`, a callback function `onRemoveExpense`, and a callback function `onEditExpense`.
 *
 * 2. User Interface:
 *
 * - The user interface consists of a ListView.builder that displays individual expenses as Dismissible widgets.
 * - Each expense item can be swiped to delete it or tapped to edit it.
 *
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom widgets and models
import 'package:app/widgets/expenses_list/expense_item.dart';
import 'package:app/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onEditExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  final void Function(Expense expense, int index) onEditExpense;

  @override
  Widget build(BuildContext context) {
    // Build the UI for displaying the list of expenses
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        // Background color for swiping to delete
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          // Invoke the callback to remove the expense
          onRemoveExpense(expenses[index]);
        },
        child: GestureDetector(
          onTap: () {
            // Invoke the callback to edit the expense
            onEditExpense(expenses[index], index);
          },
          child: ExpenseItem(expenses[index]), // Display the expense item
        ),
      ),
    );
  }
}