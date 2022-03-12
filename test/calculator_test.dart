import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terminal/views/calculator_page.dart';

void main(){
  group('All calculator Tests ',() {

    testWidgets('Calculator test', (WidgetTester tester) async{
      await tester.pumpWidget(
          MaterialApp(home:CalculatorWidgetPage()));

      final testFind = find.byType(SimpleCalculator);
      expect(testFind, findsOneWidget);

      final first = 1;
      final second = 2;

      final find1 = find.text(first.toString());
      final find2 = find.text(second.toString());

      expect(find1 , findsOneWidget);
      expect(find2 , findsOneWidget);
    });

    testWidgets('Test Multiplication Operation', (WidgetTester tester) async{
      await tester.pumpWidget(
          MaterialApp(home:CalculatorWidgetPage()));

      final testFind = find.byType(SimpleCalculator);
      expect(testFind, findsOneWidget);

      final first = 6;
      final second = 2;
      final sum = 12;
      final find1 = find.text(first.toString());
      final find2 = find.text(second.toString());
      final findOp = find.text('×');
      final findEq = find.text('=');

      expect(find1 , findsOneWidget);
      await tester.tap(find1);
      await tester.pump();

      expect(findOp , findsOneWidget);
      await tester.tap(findOp);
      await tester.pump();

      expect(find2 , findsOneWidget);
      await tester.tap(find2);
      await tester.pump();

      expect(findEq , findsOneWidget);
      await tester.tap(findEq);
      await tester.pump();

      expect(find.text(sum.toString()),findsOneWidget);
    });

  });

}