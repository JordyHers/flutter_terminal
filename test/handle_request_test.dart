import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:terminal/constants/strings.dart';
import 'package:terminal/repository/repository.dart';
import 'package:terminal/views/calculator_page.dart';
import 'package:terminal/views/home_page.dart';

import 'mocks_test.dart';


void main() {
  group('Test Handle All Requests', () {
    final rep = Repository();
    text = '';
    TextEditingController texts = TextEditingController();

   test ('Test wrong command entered',() async {
     texts.text = 'Vsrtes';
     await rep.handleRequest(texts);
     expect(text, '🛑');
   });

    test('Test Help Text',() async {
      texts.text = 'h';
      await rep.handleRequest(texts);
      expect(text, 'help/');
    });

    test('Test List of Text',() async {
      texts.text = 'ls';
      await rep.handleRequest(texts);
      expect(text, 'ls/');
    });

    test('Test Contacts command',() async {
      texts.text = 'cts';
      await rep.handleRequest(texts);
      expect(text, 'contacts/');
    });

    test('Test Jokes command',() async {
      texts.text = 'jks';
      await rep.handleRequest(texts);
      expect(text, 'jokes/');
    });


    testWidgets('When clc command is entered navigates to Calculator page',(WidgetTester tester) async {
      ///Here we setUp the the mockObserver
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Terminal',
        home: HomePage(),
        navigatorObservers: [mockObserver],
      ));
      Finder textField = find.byType(TextField);
      expect(textField,findsOneWidget);
      await tester.pump();

      texts.text = 'clc';
      await rep.handleRequest(texts);
      verifyNever(mockObserver.didPush(MaterialPageRoute(builder: (context) => CalculatorWidgetPage()), any));

    });

    test('Test Settings command',() async {
      texts.text = 'set';
      await rep.handleRequest(texts);
      expect(text, 'settings/');
    });

    test('Test Clear Function',() async {
      texts.text = 'clear';
      await rep.handleRequest(texts);
      expect(text, '');
    });

  });
}