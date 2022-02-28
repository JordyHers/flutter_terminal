import 'package:flutter/material.dart';
import 'package:terminal/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terminal',
      theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'UbuntuMono-Regular',
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.white)),
      home: HomePage(),
    );
  }
}
