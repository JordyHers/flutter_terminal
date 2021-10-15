import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Rep {
  Future<void> saveMessage(String message) async {}

  Future<String?> getMessage(int index) async {}

  Future<void> saveNotes(String note) async {}

  Future<String?> getNotes(int index) async {}

}

class Repository implements Rep {
  List<String> messages = [];
  List<String> notes = [];

  @override
  Future<void> saveMessage(String message) async {
    messages.add(message);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Messages', messages);
  }

  @override
  Future<void> saveNotes(String note) async {
    notes.add(note);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Notes', notes);
  }

  @override
  Future<String?> getMessage(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var messageList = await prefs.getStringList('Messages');
    print(messageList![index]);
    return messageList.last;
  }

  @override
  Future<String?> getNotes(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var noteList = await prefs.getStringList('Notes');
    print(noteList![index]);
    return noteList.last;
  }

  @override
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts;
    var status = await Permission.contacts.status;
    if (status.isGranted) {
         contacts = await ContactsService.getContacts();
    } else{
      await Permission.contacts.request();
      contacts = await ContactsService.getContacts();
      print('ACCESS NOT GRANTED');    }
    return contacts;
  }
}
