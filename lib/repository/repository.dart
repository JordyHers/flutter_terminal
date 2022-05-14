import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal/constants/strings.dart';

abstract class Rep {
  Future<void> saveMessage(String message) async {}

  Future<String?> getMessage(int index) async {}

  Future<void> saveNotes(String note) async {}

  Future<String?> getNotes(int index) async {}

  Future<String?> handleRequest(TextEditingController input) async {}
}

class Repository implements Rep {
  List<String> messages = [];
  List<String> notes = [];

  @override
  Future saveMessage(String message) async {
    messages.add(message);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Messages', messages);
  }

//Function to save the notes
  @override
  Future saveNotes(String note) async {
    notes.add(note);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Notes', notes);
  }

  //Function to get Messages
  @override
  Future<String?> getMessage(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var messageList = prefs.getStringList('Messages');
    print(messageList![index]);
    return messageList.last;
  }

  //Function to get the Notes
  @override
  Future<String?> getNotes(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var noteList = prefs.getStringList('Notes');
    print(noteList![index]);
    return noteList.last;
  }

  Future<String?> handleRequest(TextEditingController input) async {
    input.text = input.text.toLowerCase();
    switch (input.text) {
      case 'h':
        text = 'help/';
        print('help chosen');
        past.add(Strings.helpText);
        break;
      case 'ls':
        print('ls chosen');
        past.add(Strings.lsText);
        text = 'ls/';
        break;
      case 'cts':
        print(input.text);
        print('contacts chosen');
        past.addAll(contacts);
        print(past);
        text = 'contacts/';
        break;
      case 'jks':
        print('< jokes requested >');
        text = 'jokes/';
        break;
      case 'clc':
        print('< calculator >');
        return 'clc';
      case 'set':
        past.add(model);
        print('settings chosen');
        past.add(Strings.setText);
        text = 'settings/';
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
        print('list cleared');
        past.clear();
        text = '';
        break;
      default:
        if (input.text.contains('cd')) {
          print('cd chosen');
          past.add('${Strings.cdText} ${input.text}');
          return text = '${input.text.replaceAll('cd', '')}';
        } else if (input.text.contains('msg')) {
          repository.saveMessage(input.text);
          print('message chosen');
          past.add(Strings.msgText);
          return text = 'messages/';
        } else if (input.text.contains('not')) {
          repository.saveNotes(input.text);
          print('notes chosen');
          past.add(Strings.noteText);
          return text = 'notes/';
        } else {
          text = "";
          past.add(Strings.errorText);
        }
    }
  }
}
