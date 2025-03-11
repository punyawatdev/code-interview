import 'package:flutter/material.dart';

class FibonacciItem {
  int index;
  int number;
  IconData icon;

  FibonacciItem({
    required this.index,
    required this.number,
    required this.icon,
  });

  @override
  String toString() {
    return 'FibonacciItem(index: $index, number: $number, icon: $icon)';
  }
}
