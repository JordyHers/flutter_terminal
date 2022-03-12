import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal/repository/repository.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockRepository extends Mock implements Repository{
  List<String> messages = [];
  List<String> notes = [];

  @override
  Future saveMessage(String message) async {
    messages.add(message);
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Messages', messages);
  }

//Function to save the notes
  @override
  Future saveNotes(String note) async {
    notes.add(note);
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Notes', notes);
  }

  //Function to get Messages
  @override
  Future<String?> getMessage(int index) async {
    SharedPreferences.setMockInitialValues({'Messages':['This is a test message']});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var messageList = prefs.getStringList('Messages');
    print(messageList?[index]);
    return messageList?.last;
  }

  //Function to get the Notes
  @override
  Future<String?> getNotes(int index) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var noteList = prefs.getStringList('Notes');
    print(noteList![index]);
    return noteList.last;
  }

}