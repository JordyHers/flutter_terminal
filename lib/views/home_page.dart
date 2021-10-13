import 'package:flutter/material.dart';
import 'package:terminal/utils/config/size_config.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final input = TextEditingController();

    Future<void> submit(TextEditingController input) async{
      switch(input.text){
        case 'ls': print('ls chosen');
          break;
        case 'cd': print('cd chosen');
        break;
        default:
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
                  Text('-ls  to get list of commands',style: TextStyle(color: Colors.grey,fontSize: 11)),
                  Spacer(),
                ],
              ),),
                TextField(
                  controller: input,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  onEditingComplete: (){
                    submit(input);
                    input.clear();
                  },
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.greenAccent,
                  decoration: InputDecoration(
                      prefixText: '-> ~',
                      hintStyle: TextStyle(color: Colors.greenAccent)
                  ),),


              ]
          )),
      ),

    );
  }
}
