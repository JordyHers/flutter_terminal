import 'package:flutter/material.dart';
import 'package:terminal/constants/strings.dart';

import 'views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: FutureBuilder(
          future: Future.wait([
            service.getIpAddress().then((value) => ip = value),
            //service.getPhoneModelAndroid().then((value) => model = value!),
            service.getContacts().then((value) {
              value.forEach(
                (element) {
                  contacts.add('${element.displayName!}');
                  print('${element.displayName!}');
                },
              );
            })
          ]),
          builder: (context, AsyncSnapshot<List<String?>> snapshot) {
            if (snapshot.hasData) {
              print('ip address found: $ip');
              return HomePage();
            } else
              return LoadingWidget();
          }),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextStyle(
          child: Text('Loading'),
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        SizedBox(height: 20),
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      ],
    );
  }
}
