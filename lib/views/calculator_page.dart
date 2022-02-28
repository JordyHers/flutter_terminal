import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
class CalculatorWidgetPage extends StatelessWidget {
  const CalculatorWidgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: SimpleCalculator(
          theme: const CalculatorThemeData(
            displayColor: Colors.black,
            displayStyle: const TextStyle(fontSize: 80, color: Colors.yellow),
          ),
        ),
      ),
    );
  }
}
