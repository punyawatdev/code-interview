import 'package:flutter/material.dart';
import 'package:mobile_assignment_7solutions/models/fibonacci_item.dart';

class FibonacciModel extends ChangeNotifier {
  final List<FibonacciItem> _fibonacciItems = [];
  final List<FibonacciItem> _selectedItems = [];

  int? highlightFibonacciIndex;
  int? highlightSelectedIndex;

  List<FibonacciItem> get fibonacciNumbers => _fibonacciItems;
  List<FibonacciItem> get selectedNumbers => _selectedItems;

  void _sortItems(List<FibonacciItem> items) {
    items.sort((a, b) => a.index - b.index);
  }

  // The initFibonacciItems method initializes the _fibonacciItems list with a specified number of Fibonacci items and clears the _selectedItems list.
  void initFibonacciItems(int n) {
    _fibonacciItems.clear();
    _selectedItems.clear();
    _fibonacciItems.addAll(generateFibonacciItem(n));
    notifyListeners();
  }

  // The addItem method moves an item from _fibonacciItems to _selectedItems and sorts the _selectedItems list.
  void addItem(FibonacciItem item) {
    highlightSelectedIndex = item.index;
    _fibonacciItems.remove(item);
    _selectedItems.add(item);
    _sortItems(_selectedItems);
    notifyListeners();
  }

  // The removedItem method moves an item from _selectedItems to _fibonacciItems and sorts the _fibonacciItems list.
  void removedItem(FibonacciItem item) {
    highlightFibonacciIndex = item.index;
    _selectedItems.remove(item);
    _fibonacciItems.add(item);
    _sortItems(_fibonacciItems);
    notifyListeners();
  }

  // The getFibonacciTypeIcon method returns an icon based on the specified number.
  IconData getFibonacciTypeIcon(int number) {
    if (number % 3 == 0) {
      return Icons.circle;
    } else if (number % 3 == 1) {
      return Icons.crop_square;
    } else {
      return Icons.close;
    }
  }

  // The generateFibonacciItem method generates a list of Fibonacci items based on the specified number of items.
  List<FibonacciItem> generateFibonacciItem(int n) {
    List<FibonacciItem> fibonacci = [
      FibonacciItem(index: 0, number: 0, icon: getFibonacciTypeIcon(0)),
      FibonacciItem(index: 1, number: 1, icon: getFibonacciTypeIcon(1)),
    ];
    for (int i = 2; i < n; i++) {
      int fibonacciNumber = fibonacci[i - 1].number + fibonacci[i - 2].number;
      fibonacci.add(
        FibonacciItem(
          index: i,
          number: fibonacciNumber,
          icon: getFibonacciTypeIcon(fibonacciNumber),
        ),
      );
    }
    return fibonacci;
  }
}
