import 'package:flutter/material.dart';
import 'package:mobile_assignment_7solutions/models/fibonacci_item.dart';
import 'package:mobile_assignment_7solutions/models/fibonacci_model.dart';

import '../widgets/fibonacci_tile.dart';
import '../utils/icons_equal.dart' show areIconsEqual;

class FibonacciScreen extends StatefulWidget {
  const FibonacciScreen({super.key, required this.fibonacciModel});

  final FibonacciModel fibonacciModel;

  @override
  State<FibonacciScreen> createState() => _FibonacciScreenState();
}

class _FibonacciScreenState extends State<FibonacciScreen> {
  final _fibonacciScrollController = ScrollController();
  final _selectedScrollController = ScrollController();
  late FibonacciModel _fibonacciModel;

  @override
  void initState() {
    super.initState();
    _fibonacciModel = widget.fibonacciModel;
    _fibonacciModel.initFibonacciItems(41);
  }

  @override
  void dispose() {
    _fibonacciScrollController.dispose();
    _selectedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example')),
      body: ListView.builder(
        controller: _fibonacciScrollController,
        itemCount: _fibonacciModel.fibonacciNumbers.length,
        itemBuilder: (context, index) {
          final fibonacciNumbers = _fibonacciModel.fibonacciNumbers[index];
          final highlightIndex = _fibonacciModel.highlightFibonacciIndex;
          return FibonacciTile(
            key: ValueKey('fibonacci_tile_${fibonacciNumbers.index}'),
            item: fibonacciNumbers,
            highlight: fibonacciNumbers.index == highlightIndex,
            onTap: () {
              setState(() {
                _fibonacciModel.addItem(fibonacciNumbers);
                _showBottomSheet(context, fibonacciNumbers.icon);
              });
            },
            highlightColor: Colors.red,
          );
        },
      ),
    );
  }

  // Show Bottom Sheet Modal for selected items
  void _showBottomSheet(BuildContext context, IconData icon) {
    List<FibonacciItem> filteredItems =
        _fibonacciModel.selectedNumbers
            .where((item) => areIconsEqual(item.icon, icon))
            .toList();
    final highlightIndex = _fibonacciModel.highlightSelectedIndex;

    _scrollToSelectedItem(filteredItems, highlightIndex);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          controller: _selectedScrollController,
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final selectedNumbers = filteredItems[index];
            return FibonacciTile(
              key: ValueKey('bottom_sheet_tile_${selectedNumbers.index}'),
              item: selectedNumbers,
              highlight: selectedNumbers.index == highlightIndex,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _fibonacciModel.removedItem(selectedNumbers);
                });
                _scrollToFibonacciItem();
              },
              highlightColor: Colors.green,
              layout: FibonacciTileLayoutType.bottomSheet,
            );
          },
        );
      },
    );
  }

  void _scrollToItem(
    ScrollController controller,
    int? index,
    double itemHeight, {
    bool isFibonacci = false,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index != null) {
        final maxScrollExtent =
            controller.position.maxScrollExtent +
            (isFibonacci ? kBottomNavigationBarHeight : 0.0);
        final itemPosition = index * itemHeight;
        final offset = itemPosition.clamp(0.0, maxScrollExtent);
        controller.animateTo(
          offset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _scrollToSelectedItem(List<FibonacciItem> items, int? highlightIndex) {
    double itemHeight = 72.0;
    final index = items.indexWhere((item) => item.index == highlightIndex);
    if (index != -1) {
      highlightIndex = index;
    }
    _scrollToItem(_selectedScrollController, highlightIndex, itemHeight);
  }

  void _scrollToFibonacciItem() {
    double itemHeight = 56.0;
    int? highlightIndex = _fibonacciModel.highlightFibonacciIndex;
    final index = _fibonacciModel.fibonacciNumbers.indexWhere(
      (item) => item.index == highlightIndex,
    );
    if (index != -1) {
      highlightIndex = index;
    }
    _scrollToItem(
      _fibonacciScrollController,
      highlightIndex,
      itemHeight,
      isFibonacci: true,
    );
  }
}
