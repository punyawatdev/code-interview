import 'package:flutter/material.dart';
import 'package:mobile_assignment_7solutions/models/fibonacci_item.dart';

enum FibonacciTileLayoutType { screen, bottomSheet }

class FibonacciTile extends StatelessWidget {
  const FibonacciTile({
    super.key,
    required this.item,
    required this.highlightColor,
    this.highlight = false,
    this.onTap,
    this.layout = FibonacciTileLayoutType.screen,
  });

  final FibonacciItem item;
  final Color highlightColor;
  final bool highlight;
  final VoidCallback? onTap;
  final FibonacciTileLayoutType layout;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: highlight ? highlightColor : null,
      title: Row(
        children: [
          Text(
            layout == FibonacciTileLayoutType.bottomSheet
                ? 'Number: ${item.number}'
                : 'Index: ${item.index}, Number: ${item.number}',
          ),
          Spacer(),
          Icon(item.icon, size: 24),
        ],
      ),
      subtitle:
          layout == FibonacciTileLayoutType.bottomSheet
              ? Text('Index: ${item.index}')
              : null,
      onTap: onTap,
    );
  }
}
