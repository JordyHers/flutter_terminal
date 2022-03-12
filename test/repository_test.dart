import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terminal/constants/strings.dart';
import 'mocks_test.dart';



void main(){
  group('Get Functions',()  {

    final rep = MockRepository();
    final textField = TextEditingController();


    //Save Messages Functions
    test('saveMessage',() async {
    rep.messages =[];
    past = [];
    textField.text = 'msg';
    await rep.saveMessage(textField.text);
    past.add(textField.text);
    expect(past.isNotEmpty,true);
    expect(rep.messages.isNotEmpty, true);
    },skip:false);


    //Get Message Function
    test('getMessage',()async {
      final result = await rep.getMessage(0);
      expect(result == 'This is a test message',true);
    },skip: false);


    //____________________

    //Get Notes Functions
    test('getNote',(){

    });
    //Save Notes Functions
    test('saveNote',(){

    });

    //Get Contacts
    test('getContacts',(){

    });


  });
}