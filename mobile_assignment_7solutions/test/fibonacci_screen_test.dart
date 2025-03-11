import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_assignment_7solutions/models/fibonacci_model.dart';
import 'package:mobile_assignment_7solutions/screens/fibonacci_screen.dart';
import 'package:mobile_assignment_7solutions/widgets/fibonacci_tile.dart';

void main() {
  late FibonacciModel fibonacciModel;

  setUp(() {
    fibonacciModel = FibonacciModel();
  });

  testWidgets('FibonacciScreen displays list of Fibonacci numbers', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: FibonacciScreen(fibonacciModel: fibonacciModel)),
    );

    expect(find.byType(FibonacciTile), findsWidgets);
  });

  testWidgets('FibonacciScreen shows bottom sheet on tile tap', (
    WidgetTester tester,
  ) async {
    fibonacciModel.initFibonacciItems(10);

    await tester.pumpWidget(
      MaterialApp(home: FibonacciScreen(fibonacciModel: fibonacciModel)),
    );

    final tile = find.byKey(ValueKey('fibonacci_tile_1'));
    await tester.tap(tile);
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.byKey(ValueKey('bottom_sheet_tile_1')), findsOneWidget);
  });

  testWidgets('Bottom sheet removes item on tap', (WidgetTester tester) async {
    fibonacciModel.initFibonacciItems(10);

    await tester.pumpWidget(
      MaterialApp(home: FibonacciScreen(fibonacciModel: fibonacciModel)),
    );

    final tile = find.byKey(ValueKey('fibonacci_tile_1'));
    await tester.tap(tile);
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.byKey(ValueKey('bottom_sheet_tile_1')), findsOneWidget);

    final bottomSheetTile = find.byKey(ValueKey('bottom_sheet_tile_1'));
    await tester.tap(bottomSheetTile);
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(find.byKey(ValueKey('bottom_sheet_tile_1')), findsNothing);
  });
}
