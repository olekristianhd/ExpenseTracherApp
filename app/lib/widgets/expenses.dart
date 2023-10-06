/**
 * Expenses Widget Documentation
 *
 * The `Expenses` widget is the main screen of the Expense Tracker app. It displays a list
 * of expenses, a chart summarizing expenses, and allows users to add, edit, and remove expenses.
 *
 * Table of Contents:
 * 1. Expenses Widget
 * 2. State Management
 * 3. User Interface
 *
 * 1. Expenses Widget:
 *
 * - `Expenses` is a StatefulWidget that represents the main screen of the Expense Tracker app.
 *
 * 2. State Management:
 *
 * - `_ExpensesState` is the associated State class for `Expenses`.
 * - It manages the state of registered expenses and handles adding, editing, and removing expenses.
 *
 * 3. User Interface:
 *
 * - The user interface consists of an app bar, a chart, and an expenses list.
 * - Users can add a new expense by clicking the "Add" button in the app bar.
 * - Users can edit and remove expenses by interacting with the expenses list.
 *
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom widgets and models
import 'package:app/widgets/new_expense.dart';
import 'package:app/widgets/expenses_list/expenses_list.dart';
import 'package:app/models/expense.dart';
import 'package:app/widgets/chart/chart.dart';
import 'package:app/widgets/edit_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // List to store registered expenses
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // Function to open the "Add Expense" overlay
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // Function to add a new expense
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Function to open the "Edit Expense" overlay
  void _openEditExpense(Expense expense, int index) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => EditExpense(
        onEditExpense: (updatedExpense) {
          _editExpense(updatedExpense, index);
        },
      ),
    );
  }

  // Function to edit an existing expense
  void _editExpense(Expense updatedExpense, int index) {
    setState(() {
      _registeredExpenses[index] = updatedExpense;
    });
  }

  // Function to remove an expense
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the main content as a message when no expenses are present
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    // If there are expenses, replace the main content with the expenses list
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
        onEditExpense: _openEditExpense,
      );
    }

    // Build the main UI of the Expenses screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Display a chart summarizing expenses
          Chart(expenses: _registeredExpenses),

          // Display the main content (expenses list or message)
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}