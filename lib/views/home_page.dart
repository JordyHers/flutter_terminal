import 'dart:async';

import 'package:flutter/material.dart';
import 'package:terminal/constants/strings.dart';
import 'package:terminal/utils/config/size_config.dart';
import 'package:terminal/utils/theme/colors.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final input = TextEditingController();
    final controller = StreamController<String>();
    List<String> past =[];
    String text = '';



    Future<void> submit(input) async{
      const String app = 'APPLICATIONS';
      switch(input){
        case 'h':
          text = 'help/';
          print('help chosen');
        past.add(Strings.helpText);
          break;
        case 'cd $app':
          text = 'cd/';
          print('cd chosen');
        past.add('${Strings.cdText} $input');
          break;
          case 'ls':
          text = 'ls/';
          print('cd chosen');
        past.add(Strings.lsText);
          break;
        case 'cts':
          text= 'contacts/';
          print('contacts chosen');
          past.add(Strings.contText);
        break;
        case 'msg':
          text = input;
          print('messages chosen');
          past.add(Strings.msgText);
        break;
        case 'not':
          text ='notes/';
          print('notes chosen');
          past.add(Strings.noteText);
        break;
        case 'set':
          text= 'settings/';
          print('settings chosen');
          past.add(Strings.setText);
          break;
        case 'clear':
          print('cd chosen');
          past.clear();
        break;

        default:
        past.add('successfuly saved');
          break;

      }
    }


    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          margin:  EdgeInsets.only(top:50),
          height:SizeConfig.getHeight(context),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:[
                Text('Last login: Sat Oct  9 16:21:44 on console',style: TextStyle(color: Colors.white),
                ),
              Container(
                height: 70,
                padding: EdgeInsets.only(top:5,left: 20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                border: Border.all(width: 2,color: Colors.white)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" (　-_･) ︻デ═一 ▸    ¯\_(ツ)_/¯",style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                  Spacer(),
                  Text('-h to get list of commands',style: TextStyle(color: Colors.grey,fontSize: 11)),
                  Spacer(),
                ],
              ),),

                StreamBuilder(
                  stream: controller.stream,
                  builder: (context, AsyncSnapshot<String> snapshot){
                    if(snapshot.hasData){
                      return   ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: past.length,
                          itemBuilder: (context,index)
                          {
                            return Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: RichText(

                                text: TextSpan(
                                  text: '-> ~',
                                  style: TextStyle(color: Colors.greenAccent,fontSize: 13),
                                  children: <TextSpan>[
                                    TextSpan(text: past[index], style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'UbuntuMono-Regular')),
                                  ],
                                ),
                              ),
                            );
                          });
                    }else{
                      return Opacity(opacity: 0);
                    }

                  },
                ),

                TextField(
                  controller: input,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {
                    controller.add('-> ~ ${input.text}');
                    submit(input.text);
                    input.clear();
                  },
                  autofocus: true,
                  keyboardAppearance: Brightness.dark,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.greenAccent,
                  decoration: InputDecoration(
                      prefixText: '-> ~$text',
                      hintStyle: TextStyle(color: Colors.greenAccent)
                  ),),
              ]
          )),
      ),

    );
  }
}
