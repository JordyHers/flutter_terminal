import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terminal/constants/strings.dart';
import 'package:terminal/main.dart';
import 'package:terminal/views/home_page.dart';

import 'mocks_test.dart';

void main() {
  testWidgets('Test Homepage Widgets', (WidgetTester tester) async {
    MockService mock;
    mock = MockService();

    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terminal',
      theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'UbuntuMono-Regular',
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.white)),
      home: FutureBuilder(
          future: Future.wait([
            mock.getIpAddress().then((value) => ip = value),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              print('ip address found: $ip');
              expect(ip.isNotEmpty, false);
              expect(find.byWidget(LoadingWidget()), findsNothing);
              return HomePage();
            } else {
              print('ip address in test 2: $ip');
              expect(ip.isNotEmpty, true);
              expect(find.byWidget(HomePage()), findsNothing);
              return LoadingWidget();
            }
          }),
    ));
  });
}
