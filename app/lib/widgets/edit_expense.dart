/**
 * EditExpense Widget Documentation
 *
 * The `EditExpense` widget is responsible for displaying a form to edit an existing expense
 * in the Expense Tracker app. Users can modify the title, amount, date, and category of the
 * selected expense. The widget includes form validation and user interactions.
 *
 * Table of Contents:
 * 1. EditExpense Widget
 * 2. State Management
 * 3. User Interface
 *
 * 1. EditExpense Widget:
 *
 * - `EditExpense` is a StatefulWidget that displays the edit expense form.
 * - It receives a callback function `onEditExpense` to handle editing an expense.
 *
 * 2. State Management:
 *
 * - `_EditExpenseState` is the associated State class for `EditExpense`.
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
 * - The "Cancel" button cancels the editing process, and the "Save Expense" button saves changes.
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

// Import custom Expense model
import 'package:app/models/expense.dart';

class EditExpense extends StatefulWidget {
  const EditExpense({super.key, required this.onEditExpense});

  final void Function(Expense expense) onEditExpense;

  @override
  State<EditExpense> createState() {
    return _EditExpenseState();
  }
}

class _EditExpenseState extends State<EditExpense> {
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

  // Function to submit edited expense data
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

    // Invoke the callback to edit the expense
    widget.onEditExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    // Close the edit expense form
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
    // Build the UI for editing an expense
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
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}