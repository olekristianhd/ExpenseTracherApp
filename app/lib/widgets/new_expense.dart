/**
 * NewExpense Widget Documentation
 *
 * The `NewExpense` widget is responsible for displaying a form to add a new expense entry
 * in the Expense Tracker app. Users can input the title, amount, date, and category for
 * the new expense. The widget includes form validation and user interactions.
 *
 * Table of Contents:
 * 1. NewExpense Widget
 * 2. State Management
 * 3. User Interface
 *
 * 1. NewExpense Widget:
 *
 * - `NewExpense` is a StatefulWidget that displays the new expense form.
 * - It receives a callback function `onAddExpense` to handle adding a new expense.
 *
 * 2. State Management:
 *
 * - `_NewExpenseState` is the associated State class for `NewExpense`.
 * - It manages the state of text input controllers, selected date, and category.
 * - It handles date picker presentation and validation of form data.
 *
 * 3. User Interface:
 *
 * - The user interface consists of text fields for title and amount, a date picker,
 *   and a dropdown menu for category selection.
 * - Validation is performed for input data, and error messages are shown as AlertDialogs.
 * - Users can select a date using the date picker.
 * - Users can select a category using the dropdown menu.
 * - The "Cancel" button cancels the form, and the "Create Expense" button adds a new expense.
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom Expense model
import 'package:app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // Controllers for title and amount text fields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Selected date for the expense
  DateTime? _selectedDate;

  // Selected category for the expense
  Category _selectedCategory = Category.leisure;

  // Function to present the date picker
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Function to submit expense data
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);

    // Check for input validation
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date, and category were entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // Add the new expense using the callback function
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    // Close the expense form
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the new expense form
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
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
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
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
                child: const Text('Create Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}