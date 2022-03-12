import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:terminal/constants/strings.dart';
import 'package:terminal/models/jokes_model.dart';


import 'calculator_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dt = new DateTime.now();
  final input = TextEditingController();
  final controller = StreamController<String>();
  var randomTitle = (Strings.headers.toList()..shuffle()).last;
  List<Jokes>? fetchJokes = [];
  Timer? timer;


  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        getTitle();
        print('New title requested');
      });
    });
    service.getPhoneModelAndroid().then((value) => model = value!);
    //service.getJokesFromApi().then((value) => fetchJokes = value.cast<Jokes>());
    repository.getContacts().then((value) {
      value.forEach(
        (element) {
          contacts.add(element.displayName!);
          element.displayName!;

        },
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
  }





  Future<void> submit(TextEditingController input) async {
   var result = await repository.handleRequest(input);
   if (result == 'clc'){
     Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorWidgetPage()));
   }
   else if (result == 'jks'){
     print(fetchJokes!);
   }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: FutureBuilder(
              future: Future.wait([service.getIpAddress().then((value) => ip = value), getTitle()]) ,
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                return  Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 50),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Last login: ${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}:${dt.second} on console',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'IP Address: $ip',
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                height: 70,
                                padding: EdgeInsets.only(top: 5, left: 20),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 2, color: Colors.white)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homePageCurrentTitle,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Spacer(),
                                    Text(Strings.headerText,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 11)),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              StreamBuilder(
                                stream: controller.stream,
                                builder: (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: past.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: RichText(
                                              text: TextSpan(
                                                text: '-> ~',
                                                style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 13),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: past[index],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'UbuntuMono-Regular')),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Opacity(opacity: 0);
                                  }
                                },
                              ),
                              TextField(
                                controller: input,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                onEditingComplete: () {
                                  if (input.text.isNotEmpty) {
                                    controller.add('-> ~ ${input.text}');
                                    submit(input);
                                    input.clear();
                                  }
                                },
                                autofocus: true,
                                keyboardAppearance: Brightness.dark,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.greenAccent,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    prefixText: '-> ~$text',
                                    hintStyle:
                                        TextStyle(color: Colors.greenAccent)),
                              ),
                            ]));


              })),
    );
  }

  Future<String> getTitle() async {
    final titles = Strings.headers;
     homePageCurrentTitle  = (titles.toList()..shuffle()).first;
    return homePageCurrentTitle;
  }
}
