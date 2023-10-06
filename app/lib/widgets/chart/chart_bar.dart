/**
 * ChartBar Widget Documentation
 *
 * The `ChartBar` widget is responsible for displaying a single bar in the
 * expense distribution chart within the Expense Tracker app. It represents
 * the percentage of expenses for a particular category.
 *
 * Table of Contents:
 * 1. ChartBar Widget
 * 2. User Interface
 *
 * 1. ChartBar Widget:
 *
 * - `ChartBar` is a StatelessWidget that displays a single bar in the chart.
 * - It receives a `fill` value indicating the fill percentage of the bar.
 *
 * 2. User Interface:
 *
 * - The user interface consists of a colored bar with a height based on the `fill` value.
 * - The color of the bar depends on whether the app is in dark mode or not.
 * - The bar has rounded corners at the top.
 *
 */

// Import necessary Flutter packages
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Build the UI for a single bar in the chart
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill, // 0 <> 1
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}