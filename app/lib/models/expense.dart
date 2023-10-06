/**
 * Expense Model and Utility Classes Documentation
 *
 * This module provides documentation for the `Expense` model and utility classes
 * used in the Expense Tracker app for managing expenses, categories, and chart data.
 *
 * Table of Contents:
 * 1. Expense Model
 * 2. Category Enum
 * 3. Category Icons
 * 4. ExpenseBucket Utility Class
 *
 * 1. Expense Model:
 *
 * - The `Expense` model represents an individual expense with properties such as `id`,
 *   `title`, `amount`, `date`, and `category`. It also provides a `formattedDate` method
 *   to convert the date to a human-readable format.
 *
 * 2. Category Enum:
 *
 * - The `Category` enum defines expense categories like `food`, `travel`, `leisure`, and `work`.
 *
 * 3. Category Icons:
 *
 * - The `categoryIcons` constant maps categories to their respective icons.
 *
 * 4. ExpenseBucket Utility Class:
 *
 * - The `ExpenseBucket` class is a utility class used for organizing expenses into
 *   buckets based on their category. It calculates the total expenses within a category.
 *
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Initialize a date formatter
final formatter = DateFormat.yMd();

// Generate a unique ID for each expense using Uuid
const uuid = Uuid();

// Define an enum for expense categories
enum Category { food, travel, leisure, work }

// Define category icons for each expense category
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// Define the Expense model class
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Get the formatted date string
  String get formattedDate {
    return formatter.format(date);
  }
}

// Define the ExpenseBucket utility class
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // Constructor for creating an ExpenseBucket based on category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  // Calculate the total expenses within a category
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}