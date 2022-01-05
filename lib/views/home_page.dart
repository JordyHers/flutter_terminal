import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:terminal/constants/strings.dart';
import 'package:terminal/repository/repository.dart';
import 'package:terminal/service/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime dt = new DateTime.now();
  final input = TextEditingController();
  final controller = StreamController<String>();
  List<String> past = [];
  List<String> contacts = [];
  final service = Service();
  final repository = Repository();
  String text = '';
  String ip = '';
  String model = '';
  String? message;
  String? note;



  @override
  void initState() {
    super.initState();
    service.getPhoneModelAndroid().then((value) => model = value!);
    repository.getContacts().then((value) {
      value.forEach(
            (element) {
          contacts.add(element.displayName!);
          element.displayName!;
          print(element.displayName);
        },
      );
    });
  }

  Future<void> submit(TextEditingController input) async {
    switch (input.text) {
      case 'h':
        setState(() {
          text = 'help/';
        });
        print('help chosen');
        past.add(Strings.helpText);
        break;
      case 'ls':
        print('ls chosen');
        setState(() {
          text = 'ls/';
        });
        past.add(Strings.lsText);
        break;
      case 'cts':
        setState(() {
          text = 'contacts/';
        });
        print('contacts chosen');
        past.addAll(contacts);
        break;
      case 'set':
        past.add(model);
        setState(() {
          text = 'settings/';
        });
        print('settings chosen');
        past.add(Strings.setText);
        break;
      case 'get-m':
        await repository.getMessage(0).then((value) => message = value!);
        past.add(message!);
        break;
      case 'get-n':
        await repository.getNotes(0).then((value) => note = value!);
        past.add(note!);
        break;
      case 'clear':
        print('cd chosen');
        setState(() {
          text='';
        });
        past.clear();
        break;
      default:
        if(input.text.contains('cd')){
          setState(() {
            text = '${input.text.replaceAll('cd','')}';
          });
          print('cd chosen');
          past.add('${Strings.cdText} ${input.text}');
        }
        else if (input.text.contains('msg')) {
          repository.saveMessage(input.text);
          text = 'messages/';
          print('message chosen');
          past.add(Strings.msgText);
        } else if (input.text.contains('not')) {
          repository.saveNotes(input.text);
          text = 'notes/';
          print('notes chosen');
          past.add(Strings.noteText);
        } else {
          past.add(Strings.errorText);
        }

        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: FutureBuilder(
              future: service
                  .getIpAddress()
                  .then((value) => ip = value),
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Container(
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
                                  Strings.header,
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
                            maxLines: 2,
                            onEditingComplete: () {
                              if(input.text.isNotEmpty){
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
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixText: '-> ~$text',
                                hintStyle:
                                    TextStyle(color: Colors.greenAccent)),
                          ),
                        ]));
              })),
    );
  }
}
