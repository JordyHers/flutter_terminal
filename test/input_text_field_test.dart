import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terminal/constants/strings.dart';
import 'package:terminal/views/home_page.dart';


void main(){
  testWidgets('Test Homepage Widgets', (WidgetTester tester) async {
    final textField = find.byType(TextField);
    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terminal',
      home: HomePage(),
    ));

    // Search for the childWidget in the tree and verify it exists.
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'h');
    

  });


}